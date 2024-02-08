import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';
import 'package:pokedex_dima_new/domain/user.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/friend_profile_page.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/own_cards_trade_page.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/auth_loading_bar.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/pokemon_card_tile.dart';
import 'package:provider/provider.dart';

class FriendCardsCollectionTablet extends StatefulWidget {

  final String username;
  final User friend;
  final List<PokemonCard> friendCardsChosen;
  final Function changeBodyWidget;
  const FriendCardsCollectionTablet({super.key, required this.username, required this.changeBodyWidget, required this.friend, required this.friendCardsChosen });

  @override
  State<FriendCardsCollectionTablet> createState() => _FriendCardsCollectionTabletState();
}

class _FriendCardsCollectionTabletState extends State<FriendCardsCollectionTablet> {
  List<PokemonCard> friendCards = [];
  late List<PokemonCard> friendCardsChosen;

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
    friendCardsChosen = widget.friendCardsChosen;

    return FutureBuilder<void>(
        future: _loadAsynchronousVariables(Provider.of<UserAuthInfo?>(context, listen: false)!.email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Align(alignment: Alignment.center, child: AuthLoadingBar());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(children: [
              const SizedBox(height: 20),

              Text(
                "${widget.friend.username}'s cards",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),

              const SizedBox(height: 10),

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
            ]);
          }
        });
  }
}