import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_cards_provider.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';
import 'package:pokedex_dima_new/presentation/widgets/pokemon_card_tile.dart';
import 'package:provider/provider.dart';

class PokemonCardsList extends StatefulWidget {

  final Function changeBodyWidget;
  const PokemonCardsList({ super.key, required this.changeBodyWidget });

  @override
  State<PokemonCardsList> createState() => _PokemonCardsListState();
}

class _PokemonCardsListState extends State<PokemonCardsList> {
  List<PokemonCard>? pokemonCards;
  final TextEditingController searchController = TextEditingController();
  bool isFiltered = false;

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonCardsProvider>(context);
    final pokemonCardsFullList = pokemonProvider.pokemonCardsList;
    pokemonCards = pokemonCards ?? pokemonCardsFullList;

    return pokemonCardsFullList.isEmpty ?
    Stack(
      children: [
        const SizedBox(height: 40,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey[800]!,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  'No pokemon cards in your collection.\nAdd some from the scanner page.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[800]!,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          right: 93,
          child: Icon(
            Icons.arrow_downward,
            color: Colors.grey[800],
            size: 48,
          ),
        ),
      ],
    )

        :

    Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 0, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () { },
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
                      setState(() {
                        pokemonCards = pokemonCardsFullList;
                        isFiltered = false;
                        searchController.clear();
                      });
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search for a pokemon card...",
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
                        pokemonCards = pokemonCardsFullList;
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
                    var pokSearched = pokemonCardsFullList.where((pokemonCard) => pokemonCard.pokemonName.toLowerCase().contains(searchController.text.toLowerCase())).toList();
                    setState(() {
                      pokemonCards = pokSearched;
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

          if(pokemonCards!.isNotEmpty)
            Column(
              children: pokemonCards!.map(
                      (pokemonCard) => PokemonCardTile(
                    pokemonCard: pokemonCard,
                    changeBodyWidget: widget.changeBodyWidget,
                  )
              ).toList(),
            ),

          if(pokemonCards!.isEmpty)
            const Text("No pokemons found."),
        ]
    );
  }
}