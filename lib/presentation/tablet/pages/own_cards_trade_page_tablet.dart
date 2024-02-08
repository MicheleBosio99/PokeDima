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

class OwnTradeCardsCollectionTablet extends StatefulWidget {
  final User friend;
  final List<PokemonCard> userCardsChosen;
  final Function changeBodyWidget;
  const OwnTradeCardsCollectionTablet({super.key, required this.changeBodyWidget, required this.userCardsChosen, required this.friend});

  @override
  State<OwnTradeCardsCollectionTablet> createState() => _OwnTradeCardsCollectionTabletState();
}

class _OwnTradeCardsCollectionTabletState extends State<OwnTradeCardsCollectionTablet> {

  List<PokemonCard> userCards = [];
  late List<PokemonCard> userCardsChosen;

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
    userCardsChosen = widget.userCardsChosen;

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
                  return Column(children: [
                    const SizedBox(height: 20),

                    Text(
                      "Your cards",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),

                    const SizedBox(height: 10),

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
                  ]
                  );
                });
          }
        });
  }
}