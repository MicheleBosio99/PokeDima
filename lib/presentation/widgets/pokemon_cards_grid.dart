import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_cards_provider.dart';
import 'package:pokedex_dima_new/presentation/widgets/pokemon_card_tile.dart';
import 'package:provider/provider.dart';

class PokemonCardsGrid extends StatelessWidget {

  final Function changeBodyWidget;
  PokemonCardsGrid({super.key, required this.changeBodyWidget});

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonCardsProvider>(context);
    final pokemons = pokemonProvider.pokemonCardsList;

    return Column(
        children: [

          // TODO: add search bar

          Expanded(
            child: GridView.builder(
              itemCount: pokemons.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final pokemonCard = pokemons[index];
                return PokemonCardTile(pokemonCard: pokemonCard, changeBodyWidget: changeBodyWidget);
              },
            ),
          ),
        ]
    );
  }
}