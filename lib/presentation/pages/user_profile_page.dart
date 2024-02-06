import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_cards_provider.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/domain/user.dart';
import 'package:pokedex_dima_new/images/icons/poke_dima_icons.dart';
import 'package:pokedex_dima_new/presentation/pages/friend_list_page.dart';
import 'package:pokedex_dima_new/presentation/pages/modify_profile_page.dart';
import 'package:pokedex_dima_new/presentation/pages/trades_list_page.dart';
import 'package:pokedex_dima_new/presentation/pages/visualize_profile_image.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_loading_bar.dart';
import 'package:pokedex_dima_new/presentation/widgets/favourite_card.dart';
import 'package:pokedex_dima_new/presentation/widgets/favourite_icon.dart';
import 'package:pokedex_dima_new/presentation/widgets/single_card_show.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {

  final Function changeBodyWidget;
  const UserProfile({required this.changeBodyWidget});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late User user;
  List<String> pokemonFavourites = [];
  List<String> cardFavourites = [];

  Future<void> _loadAsynchronousVariables(email) async {
    user = (await FirebaseCloudServices().getUserUsingEmail(email))!;
    pokemonFavourites = await Favourites(favouriteType: "pokemon").loadFavourites(user.username);
    cardFavourites = await Favourites(favouriteType: "cards").loadFavourites(user.username);
  }

  @override
  Widget build(BuildContext context) {
    final email = Provider.of<UserAuthInfo?>(context, listen: false)!.email;

    return FutureBuilder(
      future: _loadAsynchronousVariables(email),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Align(alignment: Alignment.center, child: AuthLoadingBar());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          print(user.favouriteColor);
          final backgroundColor = Color(int.parse(user.favouriteColor));

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        bottom: 30,
                      ),
                      color: backgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 30,
                                left: 30,
                              ),
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
                                          VisualizeProfileImage(imageUrl: user.profilePictureUrl, changeBodyWidget: widget.changeBodyWidget),
                                          index: -1,
                                        );
                                      },
                                      onPressed: () {},
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(user.profilePictureUrl),
                                        radius: 75,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "@${user.username}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          const Column(
                            children: [],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          widget.changeBodyWidget(ModifyProfile(user: user, changeBodyWidget: widget.changeBodyWidget), index: -1);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.grey[400]),
                          shape: MaterialStateProperty.all(const CircleBorder()),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 1,
                  color: Colors.grey[700],
                  thickness: 3,
                  indent: 30,
                  endIndent: 30,
                ),

                const SizedBox(
                  height: 30,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                  child: Text(
                    user.bio,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[800],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                IntrinsicHeight(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          // right: 20,
                          left: 20,
                        ),
                        child: Container(
                          width: 250,
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
                                      user.email,
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
                                      user.realName,
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
                                      user.accountCreationDate,
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
                                      "Friends: ${user.friendsUsernames.length}",
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
                                      "Cards owned: ${Provider.of<PokemonCardsProvider>(context, listen: false).pokemonCardsList.length}",
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
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 5,
                              right: 20,
                              left: 20,
                            ),
                            child: Container(
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
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: () {
                                    widget.changeBodyWidget(FriendList(changeBodyWidget: widget.changeBodyWidget), index: -1);
                                  },
                                  icon: Icon(
                                    Icons.people_alt_rounded,
                                    color: Colors.grey[800],
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 10,
                              right: 20,
                              left: 20,
                            ),
                            child: Container(
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
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: () {
                                    widget.changeBodyWidget(TradesListPage(user: user, changeBodyWidget: widget.changeBodyWidget,), index: -1,);
                                  },
                                  icon: Icon(
                                    PokeDima.exchange_round,
                                    color: Colors.grey[800],
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Padding(
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
              ],
            ),
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
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey[700]!,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
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
            SingleCardShowImage(
              card: Provider.of<PokemonCardsProvider>(context, listen: false).getPokemonCardByPokemonName(pokemonName),
              changeBodyWidget: widget.changeBodyWidget,
              width: 118,
              height: 152,
            )
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
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey[700]!,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
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
        favouriteCards.add(FavouriteCard(pokemonName: pokemonName, changeBodyWidget: widget.changeBodyWidget,));
      }
      return favouriteCards;
    }
  }

  // Color getBackgroundColor(BuildContext context, List<String> favourites) {
  //   final pokemonProvider = Provider.of<PokemonProvider>(context, listen: false);
  //   Pokemon? pokemon;
  //   Map<PokemonType, int> pokemonTypesOccurrences = {};
  //
  //   if (favourites.length <= 1) return Colors.grey[200]!;
  //   for (var pokemonName in favourites) {
  //
  //     if (pokemonName == '') { continue; }
  //     pokemon = pokemonProvider.getPokemonByName(pokemonName);
  //
  //     if (pokemon == null) { continue; }
  //     for (var type in pokemon.pokemonTypes) {
  //       var listTypeNames = pokemonTypesOccurrences.keys.map((e) => e.name).toList();
  //       if(listTypeNames.contains(type.name)) {
  //         var foundType = pokemonTypesOccurrences.keys.firstWhere((element) => element.name == type.name);
  //         pokemonTypesOccurrences[foundType] = pokemonTypesOccurrences[foundType]! + 1;
  //       }
  //       else { pokemonTypesOccurrences[type] = 1; }
  //     }
  //   }
  //
  //   PokemonType maxType = pokemonTypesOccurrences.keys.first;
  //   int max = 0;
  //   pokemonTypesOccurrences.forEach((key, value) {
  //     if (value > max) {
  //       max = value;
  //       maxType = key;
  //     }
  //   });
  //
  //   return maxType.backgroundColor;
  // }
}