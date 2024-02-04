import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';
import 'package:pokedex_dima_new/domain/pokemon_type.dart';
import 'package:pokedex_dima_new/presentation/widgets/pokemon_tile.dart';
import 'package:pokedex_dima_new/presentation/widgets/type_box.dart';
import 'package:provider/provider.dart';

class PokemonGrid extends StatefulWidget {

  final Function changeBodyWidget;
  const PokemonGrid({ super.key, required this.changeBodyWidget });

  @override
  State<PokemonGrid> createState() => _PokemonGridState();
}

class _PokemonGridState extends State<PokemonGrid> {

  List<Pokemon>? pokemons;
  final TextEditingController searchController = TextEditingController();
  bool isFiltered = false;

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    final pokemonsFullList = pokemonProvider.pokemonList;
    if(!isFiltered) { pokemons = pokemonsFullList; }
    pokemons = pokemons ?? pokemonsFullList;

    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 0, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      elevation: 450,
                      context: context,
                      builder: (context) {
                        var allTypes = getAllPokemonTypes();
                        return StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
                            return Container(
                              height: 450,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20,),
                                    Center(
                                      child: Text(
                                        "FILTERS",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 40,),
                                    Text(
                                      "Filter by type:",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),

                                    SingleChildScrollView(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: _getTypesBoxes(setState),
                                      ),
                                    ),


                                    // TODO APPLY BUTTON
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.filter_list),
                  iconSize: 30,
                  color: Colors.grey[800],
                ),

                SizedBox(width: isFiltered ? 0 : 20,),

                Container(
                  width: 180,
                  alignment: Alignment.center,
                  child: TextFormField(
                    onFieldSubmitted: (value)  {
                      var pokSearched = pokemonsFullList.where((pokemon) => pokemon.name.toLowerCase().contains(searchController.text.toLowerCase())).toList();
                      setState(() {
                        pokemons = pokSearched;
                        isFiltered = searchController.text.isNotEmpty;
                      });
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search for a pokemon...",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                SizedBox(width: isFiltered ? 0 : 20,),

                if(isFiltered)
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        pokemons = pokemonsFullList;
                        isFiltered = false;
                        searchController.clear();
                      });
                    },
                    icon: const Icon(Icons.close),
                    iconSize: 30,
                    color: Colors.red[800],
                  ),

                IconButton(
                  onPressed: () {
                    var pokSearched = pokemonsFullList.where((pokemon) => pokemon.name.toLowerCase().contains(searchController.text.toLowerCase())).toList();
                    setState(() {
                      pokemons = pokSearched;
                      isFiltered = searchController.text.isNotEmpty;
                    });
                  },
                  icon: const Icon(Icons.search_outlined),
                  iconSize: 30,
                  color: Colors.grey[800],
                ),
              ],
            ),
          ),

          Divider(
            color: Colors.grey[800],
            thickness: 2,
            indent: 50,
            endIndent: 50,
            height: 5,
          ),

          const SizedBox(height: 10,),

          if (pokemons!.isNotEmpty)
            Expanded(
              child: GridView.builder(
                itemCount: pokemons!.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final pokemon = pokemons![index];
                  return PokemonTile(pokemon: pokemon, changeBodyWidget: widget.changeBodyWidget);
                },
              ),
            ),

          if(pokemons!.isEmpty)
            const Text("No pokemons found."),
        ]
    );
  }

  List<Widget> _getTypesBoxes(StateSetter setState) {
    var allTypes = getAllPokemonTypes();
    List<Widget> checkBoxes = [];
    for (var type in allTypes) {
      checkBoxes.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: typeBoxWithButton(
            type,
              () {
              setState(() {
                pokemons = pokemons!.where((pokemon) => pokemon.pokemonTypes.contains(type)).toList();
                isFiltered = true;
              });
            },
          ),
        ),
      );
    }
    return checkBoxes;
  }
}