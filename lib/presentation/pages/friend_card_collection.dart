import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/domain/user.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_loading_bar.dart';
import 'package:pokedex_dima_new/presentation/widgets/pokemon_card_tile.dart';
import 'package:provider/provider.dart';

class FriendCardCollection extends StatefulWidget {

  final User friend;
  final Function changeBodyWidget;
  const FriendCardCollection({ required this.changeBodyWidget, required this.friend });

  @override
  State<FriendCardCollection> createState() => _FriendCardCollectionState();
}

class _FriendCardCollectionState extends State<FriendCardCollection> {
  List<dynamic> friendCards = [];
  List<String> friendCardIds = [];

  Future<void> _loadAsynchronousVariables(email) async {
    friendCards = await FirebaseCloudServices().getPokemonCardsByUsername(widget.friend.username);
  }

  void addCardToFriendCollection(String cardId) {
    print(cardId);
    if(!friendCardIds.contains(cardId)) { friendCardIds.add(cardId); }
    else { friendCardIds.remove(cardId); }
    print(friendCardIds);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<void>(
        future: _loadAsynchronousVariables(Provider.of<UserAuthInfo?>(context, listen: false)!.email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Align(alignment: Alignment.center, child: AuthLoadingBar());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return friendCards.isEmpty ?
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey[800]!,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Text(
                      "${widget.friend.username} doesn't have any cards yet.",
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

            Stack(
              children: [
                Column(
                    children: [
                      // TODO: add search bar

                      Column(
                        children: friendCards.map<Widget>(
                                (pokemonCard) => PokemonCardTile(
                                  pokemonCard: pokemonCard,
                                  changeBodyWidget: widget.changeBodyWidget,
                                  onLongPressAdd: addCardToFriendCollection,
                                )
                        ).toList(),
                      ),
                    ]
                ),


                if(friendCardIds.isNotEmpty)
                  Positioned(
                    right: 40,
                    left: 40,
                    bottom: 20,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [

                          ElevatedButton(
                            onPressed: () {
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.all(0),
                            ),
                            child: Container(
                              height: 80,
                              width: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[850],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey[800]!,
                                  width: 2,
                                ),
                              ),
                              child: const Text(
                                'T R A D E',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ),
                          ),

                          const SizedBox(width: 20),

                          ElevatedButton(
                            onPressed: () {
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.all(0),
                            ),
                            child: Container(
                                height: 80,
                                width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey[850],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.grey[800]!,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                  size: 32,
                                )
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
              ],
            );
          }
        });
  }
}
