import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_cards_provider.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';
import 'package:pokedex_dima_new/presentation/widgets/favourite_icon.dart';
import 'package:pokedex_dima_new/presentation/pages/pokemon_cards_list_page.dart';
import 'package:pokedex_dima_new/presentation/widgets/pokemon_tile.dart';
import 'package:provider/provider.dart';


class PokemonCardInfoPage extends StatefulWidget {

  final PokemonCard pokemonCard;
  final Function changeBodyWidget;
  const PokemonCardInfoPage({ super.key, required this.pokemonCard, required this.changeBodyWidget });

  @override
  State<PokemonCardInfoPage> createState() => _PokemonCardInfoPageState();
}

class _PokemonCardInfoPageState extends State<PokemonCardInfoPage> {

  bool isPageTransitionInProgress = false;

  @override
  Widget build(BuildContext context) {
    final pokemonCard = widget.pokemonCard;
    final pokemonCardsProvider = Provider.of<PokemonCardsProvider>(context, listen: false);
    final relativePokemon = Provider.of<PokemonProvider>(context, listen: false).getPokemonByName(pokemonCard.pokemonName)!;

    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (!isPageTransitionInProgress) {
          try {
            if (details.delta.dx > 10) {
              var nextPokemonCard = pokemonCardsProvider.getPokemonCardById(_getPrevCardID(pokemonCard.id));
              isPageTransitionInProgress = true;
              widget.changeBodyWidget(PokemonCardInfoPage(pokemonCard: nextPokemonCard, changeBodyWidget: widget.changeBodyWidget));
            } else if (details.delta.dx < - 10) {
              var nextPokemonCard = pokemonCardsProvider.getPokemonCardById(_getNextCardID(pokemonCard.id, pokemonCardsProvider.pokemonCardsList.length),);
              isPageTransitionInProgress = true;
              widget.changeBodyWidget(PokemonCardInfoPage(pokemonCard: nextPokemonCard, changeBodyWidget: widget.changeBodyWidget));
            }
          } catch (e) { }
        }
      },
      onHorizontalDragEnd: (details) {
        isPageTransitionInProgress = false;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 600,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        relativePokemon.pokemonTypes.first.backgroundColor,
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),

                      Row(
                        children: [
                          // const SizedBox(width: 30,),

                          Expanded(child: _displayFormattedNumInBatch(pokemonCard.numInBatch)),

                          Image.network(
                            pokemonCard.imageUrl,
                            height: 300,
                          ),

                          Expanded(child: _getRarityIcon(pokemonCard.rarity)),

                          // const SizedBox(height: 50),
                        ],
                      ),

                      const SizedBox(height: 40),

                      SizedBox(
                        width: 200,
                        height: 200,
                        child: PokemonTile(pokemon: relativePokemon, changeBodyWidget: widget.changeBodyWidget,),
                      ),

                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        widget.changeBodyWidget(PokemonCardsList(changeBodyWidget: widget.changeBodyWidget), index: 0);
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 2.0),
                    child: FavouriteIcon(pokemonName: relativePokemon.name, favouriteType: 'cards'),
                  ),
                ),
              ],
            ),



            // TODO: delete card from collection button
          ],
        ),
      ),
    );
  }

  String _getNextCardID(String currCardID, int pokemonCardsLength) {
    print("Getting next card: $currCardID");
    int? currentID = int.tryParse(currCardID.substring(1));
    if (currentID == pokemonCardsLength - 1 || currentID == null) {
      throw Exception("LastPokemon");
    }
    return '#${(currentID + 1).toString().padLeft(3, '0')}';
  }

  String _getPrevCardID(String currCardID) {
    print("Getting prev card: $currCardID");
    int? currentID = int.tryParse(currCardID.substring(1));
    if (currentID == 0 || currentID == null) {
      throw Exception("FirstPokemon");
    }
    return '#${(currentID - 1).toString().padLeft(3, '0')}';
  }

  Widget _getRarityIcon(String rarity) {
    Icon icon;
    switch (rarity) {
      case "Common":
        icon = Icon(Icons.circle_outlined, color: Colors.grey[800], size: 32,);
      case "Uncommon":
        icon = Icon(Icons.circle, color: Colors.grey[800], size: 32,);
      case "Rare":
        icon = Icon(Icons.square_outlined, color: Colors.grey[800], size: 32,);
      case "Very Rare":
        icon = Icon(Icons.square, color: Colors.grey[800], size: 32,);
      case "Legendary":
        icon = Icon(Icons.star, color: Colors.orange[600], size: 32,);
      default:
        icon = Icon(Icons.circle_outlined, color: Colors.grey[800], size: 32,);
    }

    return SizedBox(
      width: 60,
      child: icon,
    );
  }

  Widget _displayFormattedNumInBatch(String numInBatch) {
    var parts = numInBatch.split('/');
    return SizedBox(
      width: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            parts[0],
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 1,
            thickness: 2,
            color: Colors.grey[800],
            indent: 35,
            endIndent: 35,
          ),
          Text(
            parts[1],
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
