import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/pokemon_info_page.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/type_box.dart';
import 'package:pokedex_dima_new/presentation/tablet/pages/pokemon_carousel_info_page_tablet.dart';

class PokemonTile extends StatelessWidget {

  final Pokemon pokemon;
  final isTablet;
  final Function changeBodyWidget;
  const PokemonTile({ required this.pokemon, required this.changeBodyWidget, this.isTablet = false });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isTablet) { changeBodyWidget(PokemonInfoPage(pokemon: pokemon, changeBodyWidget: changeBodyWidget)); }
        else { changeBodyWidget(PokemonCarouselInfoPageTablet(pokemonName: pokemon.name, changeBodyWidget: changeBodyWidget)); }
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Card(
          color: pokemon.pokemonTypes[0].backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          borderOnForeground: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Padding around the column// Card border behind...?
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  flex: 8,
                  child: OverflowBox(
                    minHeight: 0,
                    minWidth: 0,
                    maxHeight: 130,
                    maxWidth: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Image.network(
                        pokemon.imageUrl,
                        scale: 1.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 2,
                  child: Text(
                    pokemon.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 2,
                  child: horizontalTypeBoxes(pokemon.pokemonTypes),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}