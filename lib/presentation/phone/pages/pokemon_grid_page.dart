import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/domain/filter_pokemon.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';
import 'package:pokedex_dima_new/domain/pokemon_type.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/favourite_filter_switch.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/pokemon_selectable_type.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/pokemon_tile.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/type_box.dart';
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
  PokemonFilters? pokemonFilter;

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
                      elevation: 100,
                      context: context,
                      builder: (context) {
                        var allTypes = getAllPokemonTypes();
                        return SingleChildScrollView(
                          child: StatefulBuilder(
                            builder: (BuildContext context, StateSetter ss) {
                              pokemonFilter = PokemonFilters();
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 400,
                                padding: const EdgeInsets.all(20),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        const Center(
                                          child: Text(
                                            'FILTER POKEMON',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 12.0,),

                                        const Text(
                                          'Types:',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 12.0,),

                                        Container(
                                          color: Colors.white,
                                          height: 50,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            padding: const EdgeInsets.all(2.0),
                                            children: allTypes.map((type) => Row(children: [
                                              PokemonSelectableType(
                                                type: type,
                                                filterListRef: [], //pokemonFilter.pokemonTypesWanted,
                                              ),

                                              const SizedBox(width: 5.0,)

                                            ])).toList(),
                                          ),
                                        ),

                                        const SizedBox(height: 12.0,),

                                        const Text(
                                          'Weaknesses:',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 12.0,),

                                        Container(
                                          color: Colors.white,
                                          height: 50,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            padding: const EdgeInsets.all(2.0),
                                            children: allTypes.map((type) => Row(children: [
                                              PokemonSelectableType(
                                                type: type,
                                                filterListRef: [], //pokemonFilter.weaknessTypesWanted,
                                              ),
                                              const SizedBox(width: 5.0,)
                                            ])).toList(),
                                          ),
                                        ),

                                        const SizedBox(height: 12.0,),

                                        Row(
                                          children: [
                                            const Text(
                                              'Favourites:',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 20,),
                                            FavouriteSwitch(pokemonFilters: pokemonFilter!,),
                                          ],
                                        ),

                                        // const SizedBox(height: 12.0,),
                                        //
                                        // const Text(
                                        //   'Weight:',
                                        //   style: TextStyle(
                                        //     fontSize: 16.0,
                                        //     fontWeight: FontWeight.bold,
                                        //   ),
                                        // ),
                                        //
                                        // FilterSlidebar(rangedParam: RangedParameter(minValue: pokemonFilter.minWeight, maxValue: pokemonFilter.maxWeight)),
                                        //
                                        // const SizedBox(width: 12.0,),
                                        //
                                        // const Text(
                                        //   'Height:',
                                        //   style: TextStyle(
                                        //     fontSize: 16.0,
                                        //     fontWeight: FontWeight.bold,
                                        //   ),
                                        // ),
                                        //
                                        // FilterSlidebar(rangedParam: RangedParameter(minValue: pokemonFilter.minHeight, maxValue: pokemonFilter.maxHeight)),

                                        const SizedBox(height: 20.0,),

                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF8F0909),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.0), // Adjust the bevel as needed
                                            ),
                                          ),
                                          onPressed: () async {
                                            // var pok = await pokemonFilter!.filterPokemons(pokemons!);
                                            Navigator.pop(context);
                                            setState(() {
                                              // pokemons = pok;
                                              isFiltered = true;
                                            });
                                          },
                                          child: const Text(
                                            'APPLY',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
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
                        pokemonFilter = PokemonFilters();
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