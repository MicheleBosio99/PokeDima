import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/providers/username_provider.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_loading_bar.dart';
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
    return StreamBuilder(
      stream: FirebaseCloudServices().getStreamOfPokemonCardsByUsername(Provider.of<UsernameProvider>(context, listen: false).username),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AuthLoadingBar();
        }
        else if (snapshot.hasError || snapshot.connectionState == ConnectionState.none) { return Text('Error: ${snapshot.error}'); }
        else {
          final pokemonCardsFullList = snapshot.data;

          return pokemonCardsFullList!.isEmpty ? Stack(
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
                          padding: EdgeInsets.zero,
                          onPressed: isFiltered ? () {
                            setState(() {
                              isFiltered = false;
                              pokemonCards = null;
                              searchController.clear();
                            });
                          } : null,
                          icon: const Icon(Icons.close),
                          iconSize: 30,
                          color: isFiltered ? Colors.red[800] : Colors.grey[400]
                      ),

                      const SizedBox(width: 20,),

                      Container(
                        width: 180,
                        alignment: Alignment.center,
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            var pokSearched = pokemonCardsFullList.where((pokemonCard) => pokemonCard.pokemonName.toLowerCase().contains(searchController.text.toLowerCase())).toList();
                            setState(() {
                              pokemonCards = pokSearched;
                              print(pokemonCards);
                              isFiltered = searchController.text.isNotEmpty;
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

                      const SizedBox(width: 20,),

                      IconButton(
                        onPressed: () {
                          var pokSearched = pokemonCardsFullList.where((pokemonCard) => pokemonCard.pokemonName.toLowerCase().contains(searchController.text.toLowerCase())).toList();
                          setState(() {
                            pokemonCards = pokSearched;
                            print(pokemonCards);
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

                if((pokemonCards ?? pokemonCardsFullList).isNotEmpty)
                  Expanded(
                    child: ListView(
                      children: (pokemonCards ?? pokemonCardsFullList).map(
                              (pokemonCard) =>
                              PokemonCardTile(
                                pokemonCard: pokemonCard,
                                changeBodyWidget: widget.changeBodyWidget,
                              )
                      ).toList(),
                    ),
                  ),

                if((pokemonCards ?? pokemonCardsFullList).isEmpty)
                  const Text("No pokemons found."),
              ]
          );
        }
      }
    );
  }
}