import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';
import 'package:provider/provider.dart';

class PokemonSearchBar extends StatefulWidget {

  final Function changeBodyWidget;
  const PokemonSearchBar({super.key, required this.changeBodyWidget});

  @override
  State<PokemonSearchBar> createState() => _PokemonSearchBarState();
}

class _PokemonSearchBarState extends State<PokemonSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  var searchHistory = [];
  var queryPokemons = [];
  late List<Pokemon> allPokemons;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(queryListener);
  }

  @override
  void dispose() {
    _searchController.removeListener(queryListener);
    _searchController.dispose();
    super.dispose();
  }

  void queryListener() {
    searchPokemon(_searchController.text);
  }

  void searchPokemon(String query) {
    if (query.isEmpty) {
      setState(() {
        queryPokemons = allPokemons;
      });
    } else {
      setState(() {
        queryPokemons = allPokemons.where((pokemon) => pokemon.name.contains(query)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    final pokemons = pokemonProvider.pokemonList;
    allPokemons = pokemons;
    queryPokemons = pokemons;

    return SearchBar(
        controller: _searchController,
        hintText: 'Search Pokemon',
        shadowColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
        leading: const Icon(Icons.search),
        trailing: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
            },
          ),
        ],
        onChanged: (String query) {
          widget.changeBodyWidget(
            ListView.builder(
              itemBuilder: (context, index) {
                final pokemon = queryPokemons[index];
                return ListTile(
                  title: Text(pokemon.name),
                  onTap: () {
                    widget.changeBodyWidget(
                      Expanded(
                        child: ListView.builder(
                            itemCount: queryPokemons.isEmpty ? allPokemons.length : queryPokemons.length,
                            itemBuilder: (context, index) {
                              final pok = allPokemons.isEmpty ? allPokemons[index] : queryPokemons[index];
                              return Card(
                                child: Column(
                                  children: [
                                    Image.network(pok.imageUrl),
                                    const SizedBox(width: 5,),
                                    Text(pok.name),
                                  ],
                                ),
                              );
                            }
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        });
  }
}
