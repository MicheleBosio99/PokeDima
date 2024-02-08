import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/pokemon_info_page.dart';
import 'package:pokedex_dima_new/presentation/tablet/pages/pokemon_carousel_info_page_tablet.dart';
import 'package:provider/provider.dart';


class FavouriteCard extends StatelessWidget {

  final String pokemonName;
  final bool isTablet;
  final Function changeBodyWidget;
  const FavouriteCard({ super.key, required this.pokemonName, required this.changeBodyWidget, this.isTablet = false });

  @override
  Widget build(BuildContext context) {
    final pokemon = Provider.of<PokemonProvider>(context, listen: false).getPokemonByName(pokemonName)!;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: pokemon.pokemonTypes[0].backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey[700]!,
            width: 3,
          ),
        ),
        child: Column(
          children: [
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.all(0),
                splashFactory: NoSplash.splashFactory,
              ),
              onPressed: null,
              onLongPress: () {
                if(!isTablet) { changeBodyWidget(PokemonInfoPage(pokemon: pokemon, changeBodyWidget: changeBodyWidget)); }
                else { changeBodyWidget(PokemonCarouselInfoPageTablet(pokemonName: pokemon.name, changeBodyWidget: changeBodyWidget)); }
              },
              child: Image.network(
                pokemon.imageUrl,
                scale: 4,
              ),
            ),

            const SizedBox(width: 15,),

            Text(
              pokemon.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ),
    );
  }
}
