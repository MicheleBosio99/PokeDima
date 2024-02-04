import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/trade.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_loading_bar.dart';
import 'package:pokedex_dima_new/presentation/widgets/trade_tile.dart';


class TradesListPage extends StatefulWidget {

  final User user;
  final Function changeBodyWidget;
  const TradesListPage({ super.key, required this.user, required this.changeBodyWidget });

  @override
  State<TradesListPage> createState() => _TradesListPageState();
}

class _TradesListPageState extends State<TradesListPage> {
  final TextEditingController searchController = TextEditingController();
  List<Trade>? tradesFiltered;
  bool isFiltered = false;


  Future<List<Trade>> _loadTrades() async {
    return await FirebaseCloudServices().getAllUserTrades(widget.user.username);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _loadTrades(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) { return const AuthLoadingBar(); }
        else if (snapshot.hasError) { return const Center(child: Text("An error occurred while loading trades"),); }
        else  {
          List<Trade> allTrades = snapshot.data!;
          tradesFiltered = tradesFiltered ?? allTrades;
          return Container(
            // color: Color(int.parse(widget.user.favouriteColor)),
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
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
                              tradesFiltered = allTrades;
                              isFiltered = false;
                              searchController.clear();
                            });
                          } : null,
                          icon: const Icon(Icons.close),
                          iconSize: 30,
                          color: Colors.red[600],
                          disabledColor: Colors.grey[400],
                        ),

                        const SizedBox(width: 20,),

                        Container(
                          width: 180,
                          alignment: Alignment.center,
                          child: TextFormField(
                            onEditingComplete: () {
                              var pokSearched = allTrades.where((trade) => _tradeContainsString(trade)).toList();
                              setState(() {
                                tradesFiltered = pokSearched;
                                isFiltered = searchController.text.isNotEmpty;
                              });
                            },
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: "Search trades...",
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
                            var pokSearched = allTrades.where((trade) => _tradeContainsString(trade)).toList();
                            setState(() {
                              tradesFiltered = pokSearched;
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
                  ),

                  const SizedBox(height: 10,),

                  if(tradesFiltered!.isEmpty)
                    const Text("No trade was found"),

                  if(tradesFiltered!.isNotEmpty)
                    Column(
                      children: tradesFiltered!.map(
                              (trade) => TradeTile(
                            user: widget.user,
                            trade: trade,
                            changeBodyWidget: widget.changeBodyWidget,
                          )
                      ).toList(),
                    ),
                ],
              ),
            ),
          );
        }

      },
    );
  }

  bool _tradeContainsString(Trade trade) {
    var search = searchController.text.toLowerCase();

    if(trade.tradeId.toLowerCase().contains(search)) { return true; }
    if(trade.senderUsername.toLowerCase().contains(search)) { return true; }
    if(trade.receiverUsername.toLowerCase().contains(search)) { return true; }
    for(var pokemonCard in trade.pokemonCardsOffered) {
      if(pokemonCard.pokemonName.toLowerCase().contains(search)) { return true; }
    }
    for(var pokemonCard in trade.pokemonCardsRequested) {
      if(pokemonCard.pokemonName.toLowerCase().contains(search)) { return true; }
    }
    return false;
  }

  void _openFilterDialog() {  }
}