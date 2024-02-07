import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/images/icons/poke_dima_icons.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/friend_card_collection.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/friend_list_page.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/auth_loading_bar.dart';

class FriendProfile extends StatefulWidget {

  final String username;
  final User friend;
  final Function changeBodyWidget;
  const FriendProfile({ required this.changeBodyWidget, required this.friend, required this.username });

  @override
  State<FriendProfile> createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {

  Future<bool> _isAlreadyFriend() async {
   return await FirebaseCloudServices().isAlreadyFriend(widget.username, widget.friend.username);
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.friend;
    final backgroundColor = Color(int.parse(user.favouriteColor));

    return FutureBuilder(
      future: _isAlreadyFriend(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Align(alignment: Alignment.center, child: AuthLoadingBar());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var isAlreadyFriend = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 30,),
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
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(user.profilePictureUrl),
                                      radius: 75,
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
                      left: 5,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 32,
                        ),
                        onPressed: () {
                          widget.changeBodyWidget(FriendList(changeBodyWidget: widget.changeBodyWidget), index: -1);
                        },
                      ),
                    ),

                    if(isAlreadyFriend)
                      Positioned(
                        top: 5,
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
                            widget.changeBodyWidget(FriendList(changeBodyWidget: widget.changeBodyWidget), index: -1);
                          },
                        ),
                      ),

                    if(!isAlreadyFriend)
                      Positioned(
                        top: 5,
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
                            widget.changeBodyWidget(FriendList(changeBodyWidget: widget.changeBodyWidget), index: -1);
                          },
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

                const SizedBox(height: 30,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  child: Text(
                    user.bio,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[800],
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                "Account creation date: ${user.accountCreationDate}",
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
                                "Follow: ${user.friendsUsernames.length}",
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

                // const SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,),
                  child: TextButton(
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
                      child: Column(
                        children: [
                          const Icon(
                            PokeDima.cards,
                            size: 45,
                          ),

                          const SizedBox(height: 10,),

                          Text(
                            "${user.username}'s cards",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      widget.changeBodyWidget(FriendCardsCollection(username: widget.username, friend: user, changeBodyWidget: widget.changeBodyWidget,), index: -1);
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}