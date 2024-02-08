import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';
import 'package:pokedex_dima_new/domain/user.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/favourite_icon.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/pokemon_grid_page.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/type_box.dart';
import 'package:provider/provider.dart';


class PokemonInfoPageForCarouselTablet extends StatefulWidget {

  final Pokemon pokemon;
  final Function changeBodyWidget;
  const PokemonInfoPageForCarouselTablet({ super.key, required this.pokemon, required this.changeBodyWidget });

  @override
  State<PokemonInfoPageForCarouselTablet> createState() => _PokemonInfoPageForCarouselTabletState();
}

class _PokemonInfoPageForCarouselTabletState extends State<PokemonInfoPageForCarouselTablet> {

  bool isPageTransitionInProgress = false;

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    final pokemonProvider = Provider.of<PokemonProvider>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
          color: Colors.grey[800]!,
          width: 3,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 240,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: pokemon.pokemonTypes[0].backgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(pokemon.imageUrl),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 2.0),
                    child: FavouriteIcon(pokemonName: pokemon.name, favouriteType: "pokemon",),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pokemon.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      horizontalTypeBoxes(pokemon.pokemonTypes, distance: 20.0),
                    ],
                  ),
                  Text(
                    pokemon.id,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 18.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          pokemon.xDescription,
                          style: TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18.0,),

                  const Text(
                    "Characteristics",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 12.0,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "height : ${pokemon.height}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(width: 20.0,),

                      Text(
                        "weight : ${pokemon.weight}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          height: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24.0,),

                  const Text(
                    "Weaknesses",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1,
                    ),
                  ),

                  const SizedBox(height: 12.0,),

                  SizedBox(
                    height: 25,
                    child: weaknessBoxes(pokemon.weaknesses),
                  ),

                  const SizedBox(height: 24.0,),

                  const Text(
                    "Evolutions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1,
                    ),
                  ),

                  const SizedBox(height: 20.0,),

                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: getEvolutionImages(pokemon, context, pokemonProvider),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

  }

  List<Widget> getEvolutionImages(Pokemon pokemon, BuildContext context, PokemonProvider pokemonProvider) {
    return pokemon.evolutions.fold([], (list, pokemonID) {

      final pokemonEvolution = Provider.of<PokemonProvider>(context, listen: false).getPokemonById(pokemonID);
      if (pokemonEvolution == null) { throw ''; }
      if (pokemon.id == pokemonID) {
        list.add(
          Image.network(pokemonEvolution.imageUrl, width: 90, height: 90, fit: BoxFit.contain),
        );
      } else {
        list.add(
          Opacity(
            opacity: (0.5),
            child: Image.network(pokemonEvolution.imageUrl, width: 90, height: 90, fit: BoxFit.contain),
          ),
        );
      }
      if (pokemonID != pokemon.evolutions.last) {
        list.add(const Icon(Icons.arrow_forward));
      }
      return list;
    });
  }

  String _getNextPokemonID(String currPokemonID) {
    int? currentID = int.tryParse(currPokemonID.substring(1));
    if (currentID == 809) {
      throw Exception("LastPokemon");
    } // Wrong now, to get from the repository length
    return '#${((currentID ?? 0) + 1).toString().padLeft(3, '0')}';
  }

  String _getPrevPokemonID(String currPokemonID) {
    int? currentID = int.tryParse(currPokemonID.substring(1));
    if (currentID == 0) {
      throw Exception("FirstPokemon");
    }
    return '#${((currentID ?? 0) - 1).toString().padLeft(3, '0')}';
  }
}
