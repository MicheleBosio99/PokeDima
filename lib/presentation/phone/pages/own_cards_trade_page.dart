import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_cards_provider.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/trade.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';
import 'package:pokedex_dima_new/domain/user.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/friend_card_collection.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/friend_profile_page.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/auth_loading_bar.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/pokemon_card_tile.dart';
import 'package:provider/provider.dart';

class OwnTradeCardsCollection extends StatefulWidget {
  final User friend;
  final List<PokemonCard> friendCardsChosen;
  final Function changeBodyWidget;
  const OwnTradeCardsCollection({super.key, required this.changeBodyWidget, required this.friendCardsChosen, required this.friend});

  @override
  State<OwnTradeCardsCollection> createState() => _OwnTradeCardsCollectionState();
}

class _OwnTradeCardsCollectionState extends State<OwnTradeCardsCollection> {
  List<PokemonCard> userCards = [];
  List<PokemonCard> userCardsChosen = [];

  Future<User> _loadAsynchronousVariables(email) async {
    return (await FirebaseCloudServices().getUserUsingEmail(Provider.of<UserAuthInfo?>(context, listen: false)!.email))!;
  }

  void addCardToFriendCollection(String cardId) {
    var card = userCards.firstWhere((element) => element.id == cardId);
    if (!userCardsChosen.contains(card)) {
      userCardsChosen.add(card);
    } else {
      userCardsChosen.remove(card);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadAsynchronousVariables(Provider.of<UserAuthInfo?>(context, listen: false)!.email),
        builder: (context, snapshotFuture) {
          if (snapshotFuture.connectionState == ConnectionState.waiting) {
            return const Align(alignment: Alignment.center, child: AuthLoadingBar());
          } else if (snapshotFuture.hasError) {
            return Text('Error: ${snapshotFuture.error}');
          } else {
            final user = snapshotFuture.data!;
            return StreamBuilder(
                stream: FirebaseCloudServices().getStreamOfPokemonCardsByUsername(user.username),
                builder: (context, snapshotStream) {
                  if (snapshotStream.connectionState == ConnectionState.waiting) { return const AuthLoadingBar(); }
                  else if (snapshotStream.hasError) { return Text('Error: ${snapshotStream.error}'); }

                  userCards = snapshotStream.data!;
                  return Stack(
                    children: [
                      Column(children: [
                        const SizedBox(height: 60),

                        if (userCards.isNotEmpty)
                          Expanded(
                            child: ListView(
                              children: userCards
                                  .map<Widget>((pokemonCard) => PokemonCardTile(
                                        pokemonCard: pokemonCard,
                                        changeBodyWidget: widget.changeBodyWidget,
                                        onLongPressAdd: addCardToFriendCollection,
                                      ))
                                  .toList(),
                            ),
                          ),

                        if (userCards.isEmpty)
                          Center(
                            child: Column(children: [
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
                            ]),
                          ),
                      ]),
                      Positioned(
                        top: -10,
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
                                  widget.changeBodyWidget(FriendCardsCollection(
                                    username: user!.username,
                                    friend: widget.friend,
                                    changeBodyWidget: widget.changeBodyWidget,
                                  ));
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
                        top: -10,
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
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.all(0),
                                  ),
                                  onPressed: () async {
                                    if (userCardsChosen.isEmpty && widget.friendCardsChosen.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Center(
                                              child: Text(
                                            "You cannot create an empty trade!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      var numOfTrades = await FirebaseCloudServices().getNumberOfTradesAmongTwoUsers(user!.username, widget.friend.username);
                                      var firstLetterUsername = user.username[0].toUpperCase();
                                      var firstLetterFriend = widget.friend.username[0].toUpperCase();
                                      FirebaseCloudServices().uploadNewTrade(
                                          Trade(
                                            tradeId: "${firstLetterUsername}${firstLetterFriend}${(numOfTrades + 1).toString()}",
                                            senderUsername: user.username,
                                            receiverUsername: widget.friend.username,
                                            pokemonCardsOffered: [],
                                            pokemonCardsRequested: [],
                                            status: 'pending',
                                            timestamp: DateTime.now().toString(),
                                          ),
                                          userCardsChosen,
                                          widget.friendCardsChosen);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Center(
                                            child: Text(
                                              "Trade proposal sent to ${widget.friend.username}",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                      widget.changeBodyWidget(
                                        FriendProfile(
                                          changeBodyWidget: widget.changeBodyWidget,
                                          friend: widget.friend,
                                          username: user.username,
                                        ),
                                        index: -1,
                                      );
                                    }
                                  },
                                  child: Container(
                                      height: 45,
                                      width: 120,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green[700],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Trade',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Icon(
                                            Icons.compare_arrows_rounded,
                                            color: Colors.white,
                                            size: 32,
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }
        });
  }
}
