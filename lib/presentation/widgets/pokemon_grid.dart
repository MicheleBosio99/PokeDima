import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/pokemon_provider.dart';
import 'package:pokedex_dima_new/presentation/widgets/pokemon_tiles.dart';
import 'package:provider/provider.dart';


class PokemonGrid extends StatelessWidget {

  final Function changeBodyWidget;
  const PokemonGrid({ super.key, required this.changeBodyWidget });

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    final pokemons = pokemonProvider.pokemonList;

    return Container(
      color: Colors.white,
      child: GridView.builder(
        itemCount: pokemons.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final pokemon = pokemons[index];
          return PokemonTile(pokemon: pokemon, changeBodyWidget: changeBodyWidget);
        },
      ),
    );
  }
}