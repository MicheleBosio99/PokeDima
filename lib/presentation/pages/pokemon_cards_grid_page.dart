import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_cards_provider.dart';
import 'package:pokedex_dima_new/presentation/widgets/pokemon_card_tile.dart';
import 'package:provider/provider.dart';

class PokemonCardsGrid extends StatelessWidget {

  final Function changeBodyWidget;
  PokemonCardsGrid({ super.key, required this.changeBodyWidget });

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonCardsProvider>(context);
    final pokemonCards = pokemonProvider.pokemonCardsList;

    return pokemonCards.isEmpty ?
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Text(
                  "No pokemons cards found.\nAdd new cards from the scanner page.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),

              ),

              ),
            ),
          ),
        )

        :

        Column(
          children: [
            // TODO: add search bar

            Column(
              children: pokemonCards.map(
                      (pokemonCard) => PokemonCardTile(
                        pokemonCard: pokemonCard,
                        changeBodyWidget: changeBodyWidget,
                      )
              ).toList(),
            ),
          ]
        );
  }
}