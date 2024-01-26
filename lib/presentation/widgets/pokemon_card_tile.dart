import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';

class PokemonCardTile extends StatelessWidget {

  final PokemonCard pokemonCard;
  final Function changeBodyWidget;
  const PokemonCardTile({ super.key, required this.pokemonCard, required this.changeBodyWidget });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: changeBodyWidget(PokemonCardInfoPage(pokemon: pokemon, changeBodyWidget: changeBodyWidget,));
        },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(pokemonCard.pokemonName //Image
          // image: ,
        ),
      ),
    );
  }
}
