import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/trade.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';
import 'package:pokedex_dima_new/images/icons/poke_dima_icons.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/auth_loading_bar.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/favourite_card.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/favourite_icon.dart';
import 'package:pokedex_dima_new/presentation/tablet/pages/friend_card_collection_tablet.dart';
import 'package:pokedex_dima_new/presentation/tablet/pages/own_cards_trade_page_tablet.dart';
import 'package:pokedex_dima_new/presentation/tablet/pages/user_profile_page_tablet.dart';
import '../../phone/pages/visualize_profile_image.dart';

class FriendProfileTablet extends StatefulWidget {

  final String username;
  final User friend;
  final Function changeBodyWidget;
  const FriendProfileTablet({ required this.changeBodyWidget, required this.friend, required this.username });

  @override
  State<FriendProfileTablet> createState() => _FriendProfileTabletState();
}

class _FriendProfileTabletState extends State<FriendProfileTablet> {

  List<PokemonCard> userCardsChosen = [];
  List<PokemonCard> friendCardsChosen = [];

  List<String> pokemonFavourites = [];
  List<String> cardFavourites = [];

  int friendCardsLength = 0;


  Future<bool> _isAlreadyFriend() async {
    pokemonFavourites = await Favourites(favouriteType: "pokemon").loadFavourites(widget.friend.username);
    cardFavourites = await Favourites(favouriteType: "cards").loadFavourites(widget.friend.username);
    friendCardsLength = (await FirebaseCloudServices().getPokemonCardsByUsername(widget.friend.username)).length;
    return await FirebaseCloudServices().isAlreadyFriend(widget.username, widget.friend.username);
  }

  @override
  Widget build(BuildContext context) {
    final friend = widget.friend;
    final backgroundColor = Color(int.parse(friend.favouriteColor));

    return FutureBuilder(
      future: _isAlreadyFriend(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) { return const Align(alignment: Alignment.center, child: AuthLoadingBar()); }
        else if (snapshot.hasError) { return Text('Error: ${snapshot.error}'); }
        else {
          var isAlreadyFriend = snapshot.data!;

          return Stack(
            children: [
              Row(
                children: [

                  const SizedBox(width: 20,),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 30,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 30, left: 30,),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.transparent,
                                                  border: Border.all(
                                                    color: Colors.grey[700]!,
                                                    width: 3,
                                                  ),
                                                ),
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.transparent,
                                                    elevation: 0,
                                                    shadowColor: Colors.transparent,
                                                    padding: const EdgeInsets.all(0),
                                                  ),
                                                  onLongPress: () {
                                                    widget.changeBodyWidget(
                                                      VisualizeProfileImage(imageUrl: friend.profilePictureUrl, changeBodyWidget: widget.changeBodyWidget, isTablet: true),
                                                      index: -1,
                                                    );
                                                  },
                                                  onPressed: () {},
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.transparent,
                                                    backgroundImage: NetworkImage(friend.profilePictureUrl),
                                                    radius: 75,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "@${friend.username}",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(width: 40,),
                                      ],
                                    ),
                                  ),

                                  Positioned(
                                    top: 30,
                                    left: 5,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        size: 32,
                                      ),
                                      onPressed: () {
                                        widget.changeBodyWidget(UserProfileTablet(changeBodyWidget: widget.changeBodyWidget), index: -1);
                                      },
                                    ),
                                  ),

                                  if(isAlreadyFriend)
                                    Positioned(
                                      top: 30,
                                      right: 5,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.remove_circle_outline_sharp,
                                          color: Colors.grey[800],
                                          size: 32,
                                        ),
                                        onPressed: () {
                                          FirebaseCloudServices().removeFriendOfUser(widget.username, widget.friend.username);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.grey[850],
                                              content:
                                              const Center(
                                                child: Text(
                                                  "Friend has been removed",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              duration: const Duration(seconds: 2,),
                                            ),
                                          );
                                          FirebaseCloudServices().removeAllTradesWithUser(widget.username, widget.friend.username);
                                          widget.changeBodyWidget(UserProfileTablet(changeBodyWidget: widget.changeBodyWidget), index: -1);
                                        },
                                      ),
                                    ),

                                  if(!isAlreadyFriend)
                                    Positioned(
                                      top: 15,
                                      right: 5,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add_circle_outline_sharp,
                                          color: Colors.grey[800],
                                          size: 32,
                                        ),
                                        onPressed: () async {
                                          await FirebaseCloudServices().addFriendWithUsername(widget.username, widget.friend.username);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.grey[850],
                                              content:
                                              const Center(
                                                child: Text(
                                                  "Friend has been added",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              duration: const Duration(seconds: 2,),
                                            ),
                                          );
                                          widget.changeBodyWidget(UserProfileTablet(changeBodyWidget: widget.changeBodyWidget), index: -1);
                                        },
                                      ),
                                    ),

                                ],
                              ),

                              Divider(
                                height: 15,
                                color: Colors.grey[700],
                                thickness: 3,
                                indent: 20,
                                endIndent: 20,
                              ),

                              const SizedBox(height: 30,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                                child: Text(
                                  friend.bio,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Container(
                                      width: 338,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.grey[700]!,
                                          width: 2,
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.email,
                                                  color: Colors.grey[800],
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  friend.email,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  color: Colors.grey[800],
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  friend.realName,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.date_range_sharp,
                                                  color: Colors.grey[800],
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  friend.accountCreationDate,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.people_rounded,
                                                  color: Colors.grey[800],
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  "Friends: ${friend.friendsUsernames.length}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  PokeDima.cards,
                                                  color: Colors.grey[800],
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  "Cards owned: $friendCardsLength",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 30,),

                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.grey[700]!,
                                        width: 2,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Favourites",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Divider(
                                          color: Colors.grey[500],
                                          thickness: 3,
                                          height: 0,
                                          indent: 10,
                                          endIndent: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 15),
                                                child: Column(
                                                  children: getFavouritePokemon(pokemonFavourites)!,
                                                ),
                                              ),
                                              VerticalDivider(
                                                color: Colors.grey[500],
                                                thickness: 3,
                                                width: 0,
                                                endIndent: 5,
                                              ),
                                              Column(
                                                children: getFavouriteCards(cardFavourites)!,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 8,),

                  VerticalDivider(
                    width: 1,
                    color: Colors.grey[400],
                    thickness: 2,
                    indent: 50,
                    endIndent: 50,
                  ),

                  const SizedBox(width: 8,),

                  Expanded(
                    child: SizedBox(
                      height: 720,
                      child: FriendCardsCollectionTablet(
                        username: widget.username,
                        friend: friend,
                        friendCardsChosen: friendCardsChosen,
                        changeBodyWidget: widget.changeBodyWidget,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8,),

                  VerticalDivider(
                    width: 1,
                    color: Colors.grey[400],
                    thickness: 2,
                    indent: 50,
                    endIndent: 150,
                  ),

                  const SizedBox(width: 8,),

                  Expanded(
                    child: SizedBox(
                        height: 720,
                        child: OwnTradeCardsCollectionTablet(
                          friend: friend,
                          userCardsChosen: userCardsChosen,
                          changeBodyWidget: widget.changeBodyWidget,
                        )
                    ),
                  ),


                  const SizedBox(width: 20,),
                ],
              ),



              Positioned(
                bottom: 40,
                right: 305,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                  ),
                  onPressed: () async {
                    if (userCardsChosen.isEmpty && friendCardsChosen.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Center(
                              child: Text(
                                "You cannot create an empty trade!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      var numOfTrades = await FirebaseCloudServices().getNumberOfTradesAmongTwoUsers(widget.username, widget.friend.username);
                      var firstLetterUsername = widget.username[0].toUpperCase();
                      var firstLetterFriend = widget.friend.username[0].toUpperCase();
                      FirebaseCloudServices().uploadNewTrade(
                          Trade(
                            tradeId: "$firstLetterUsername$firstLetterFriend${(numOfTrades + 1).toString()}",
                            senderUsername: widget.username,
                            receiverUsername: widget.friend.username,
                            pokemonCardsOffered: [],
                            pokemonCardsRequested: [],
                            status: 'pending',
                            timestamp: DateTime.now().toString(),
                          ),
                          userCardsChosen,
                          friendCardsChosen);
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
                        FriendProfileTablet(
                          changeBodyWidget: widget.changeBodyWidget,
                          friend: widget.friend,
                          username: widget.username,
                        ),
                        index: -1,
                      );
                    }
                  },
                  child: Container(
                      height: 60,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ask for trade',
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
                      ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  List<Widget>? getFavouriteCards(List<String> favourites) {
    List<Widget> favouriteCards = [];

    if (favourites.isEmpty) {
      favouriteCards.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey[700]!,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "No favourites",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
        ),
      );
      return favouriteCards;
    } else {
      for (var pokemonName in favourites) {
        favouriteCards.add(
            // SingleCardShowImage(
            //   card: Provider.of<PokemonCardsProvider>(context, listen: false).getPokemonCardByPokemonName(pokemonName),
            //   changeBodyWidget: widget.changeBodyWidget,
            //   width: 118,
            //   height: 152,
            // )
          Placeholder()
        );
      }
      return favouriteCards;
    }
  }

  List<Widget>? getFavouritePokemon(List<String> favourites) {
    List<Widget> favouriteCards = [];

    if (favourites.isEmpty) {
      favouriteCards.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey[700]!,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "No favourites",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
        ),
      );
      return favouriteCards;
    } else {
      for (var pokemonName in favourites) {
        favouriteCards.add(FavouriteCard(pokemonName: pokemonName, isTablet: true, changeBodyWidget: widget.changeBodyWidget,));
      }
      return favouriteCards;
    }
  }
}