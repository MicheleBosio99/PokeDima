import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';
import 'package:pokedex_dima_new/domain/user.dart';
import 'package:pokedex_dima_new/presentation/pages/friend_profile_page.dart';
import 'package:pokedex_dima_new/presentation/pages/own_cards_trade_page.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_loading_bar.dart';
import 'package:pokedex_dima_new/presentation/widgets/pokemon_card_tile.dart';
import 'package:provider/provider.dart';

class FriendCardsCollection extends StatefulWidget {

  final String username;
  final User friend;
  final Function changeBodyWidget;
  const FriendCardsCollection({super.key, required this.username, required this.changeBodyWidget, required this.friend});

  @override
  State<FriendCardsCollection> createState() => _FriendCardsCollectionState();
}

class _FriendCardsCollectionState extends State<FriendCardsCollection> {
  List<PokemonCard> friendCards = [];
  List<PokemonCard> friendCardsChosen = [];

  Future<void> _loadAsynchronousVariables(email) async {
    friendCards = await FirebaseCloudServices().getPokemonCardsByUsername(widget.friend.username);
  }

  void addCardToFriendCollection(String cardId) {
    var card = friendCards.firstWhere((element) => element.id == cardId);
    if (!friendCardsChosen.contains(card)) {
      friendCardsChosen.add(card);
    } else {
      friendCardsChosen.remove(card);
    }
    print(cardId);
    print(friendCardsChosen.length);
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
            return Stack(
              children: [
                Column(children: [
                  const SizedBox(height: 50),

                  // TODO: add search bar

                  if(friendCards.isNotEmpty)
                    Expanded(
                      child: ListView(
                        children: friendCards.map<Widget>(
                                (pokemonCard) => PokemonCardTile(
                                  pokemonCard: pokemonCard,
                                  changeBodyWidget: widget.changeBodyWidget,
                                  onLongPressAdd: addCardToFriendCollection,
                                ))
                            .toList(),
                      ),
                    ),

                  if(friendCards.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(int.parse(widget.friend.favouriteColor)),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey[800]!,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Text(
                                  "${widget.friend.username} doesn't have any cards yet, but you can still donate some cards to him/her.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                      ),
                    ),
                ]),


                Positioned(
                  top: -15,
                  left: -15,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: 20,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            widget.changeBodyWidget(FriendProfile(changeBodyWidget: widget.changeBodyWidget, friend: widget.friend, username: widget.username));
                          },
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.grey[800],
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Go back',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -15,
                  right: -15,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'You cards',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          onPressed: () {
                            widget.changeBodyWidget(
                              OwnTradeCardsCollection(
                                friend: widget.friend,
                                friendCardsChosen: friendCardsChosen,
                                changeBodyWidget: widget.changeBodyWidget,
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.grey[800],
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        });
  }
}

// return friendCards.isEmpty
// ? Center(
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20),
// child: Container(
// decoration: BoxDecoration(
// color: Colors.grey[300],
// borderRadius: BorderRadius.circular(20),
// border: Border.all(
// color: Colors.grey[800]!,
// width: 2,
// ),
// ),
// child: Padding(
// padding: const EdgeInsets.all(25),
// child: Text(
// "${widget.friend.username} doesn't have any cards yet.",
// textAlign: TextAlign.center,
// style: TextStyle(
// fontSize: 32,
// color: Colors.grey[800],
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
// ),
// ),
// )
//
//
//     : Stack(
// children: [
// Column(children: [
// const SizedBox(height: 50),
//
// // TODO: add search bar
//
// Column(
// children: friendCards
//     .map<Widget>((pokemonCard) => PokemonCardTile(
// pokemonCard: pokemonCard,
// changeBodyWidget: widget.changeBodyWidget,
// onLongPressAdd: addCardToFriendCollection,
// ))
//     .toList(),
// ),
// ]),
//
//
// Positioned(
// top: -15,
// left: -15,
// child: Padding(
// padding: const EdgeInsets.only(
// right: 20,
// left: 20,
// top: 20,
// ),
// child: Row(
// children: [
// IconButton(
// onPressed: () {
// widget.changeBodyWidget(FriendProfile(changeBodyWidget: widget.changeBodyWidget, friend: widget.friend, username: widget.username));
// },
// icon: Icon(
// Icons.arrow_back_rounded,
// color: Colors.grey[800],
// size: 32,
// ),
// ),
// const SizedBox(width: 5),
// Text(
// 'Go back',
// textAlign: TextAlign.center,
// style: TextStyle(
// fontSize: 18,
// color: Colors.grey[800],
// fontWeight: FontWeight.bold,
// ),
// ),
// ],
// ),
// ),
// ),
//
//
// Positioned(
// top: -15,
// right: -15,
// child: Padding(
// padding: const EdgeInsets.only(
// right: 20,
// left: 20,
// top: 20,
// ),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Text(
// 'You cards',
// textAlign: TextAlign.center,
// style: TextStyle(
// fontSize: 18,
// color: Colors.grey[800],
// fontWeight: FontWeight.bold,
// ),
// ),
// const SizedBox(width: 5),
// IconButton(
// onPressed: () {
// widget.changeBodyWidget(
// OwnTradeCardsCollection(
// friend: widget.friend,
// friendCardsChosen: friendCardsChosen,
// changeBodyWidget: widget.changeBodyWidget,
// ),
// );
// },
// icon: Icon(
// Icons.arrow_forward_rounded,
// color: Colors.grey[800],
// size: 32,
// ),
// ),
// ],
// ),
// ),
// ),
// ],
// );
