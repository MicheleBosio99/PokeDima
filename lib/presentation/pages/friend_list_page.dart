import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/domain/user.dart';
import 'package:pokedex_dima_new/presentation/pages/friend_profile_page.dart';
import 'package:pokedex_dima_new/presentation/pages/search_friend.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_loading_bar.dart';
import 'package:pokedex_dima_new/presentation/widgets/friend_list_tile.dart';
import 'package:provider/provider.dart';

class FriendList extends StatefulWidget {

  final Function changeBodyWidget;
  const FriendList({ required this.changeBodyWidget});

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  late User user;
  late List<User> friends;

  Future<void> _loadAsynchronousVariables(email) async {
    user = (await FirebaseCloudServices().getUserUsingEmail(email))!;
    friends = await FirebaseCloudServices().getUserFriendListFromUsername(user.username);
  }

  @override
  Widget build(BuildContext context) {
    final email = Provider.of<UserAuthInfo?>(context, listen: false)!.email;

    return FutureBuilder<void>(
      future: _loadAsynchronousVariables(email),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Align(alignment: Alignment.center, child: AuthLoadingBar());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30,),

                  Row(
                    children: [
                      Container(
                        width: 260,
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Friends List",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 40,),

                      IconButton(
                        onPressed: () { widget.changeBodyWidget(SearchFriend(changeBodyWidget: widget.changeBodyWidget), index: -1); },
                        icon: const Icon(Icons.search_sharp),
                        iconSize: 30,
                        color: Colors.grey[800],
                      ),


                    ],
                  ),

                  Divider(
                    color: Colors.grey[800],
                    thickness: 2,
                    indent: 50,
                    endIndent: 50,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0,),
                    child: Container(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        child: Column(
                          children: _getListOfFriendsTile(friends, widget.changeBodyWidget),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  List<Widget> _getListOfFriendsTile(List<User> friends, Function changeBodyWidget) {
    List<Widget> listOfFriendsTile = [];
    for(var friend in friends) {
      listOfFriendsTile.add(
        GestureDetector(
          onTap: () { widget.changeBodyWidget(FriendProfile(changeBodyWidget: widget.changeBodyWidget, friend: friend, username: user.username), index: -1); },
          child: FriendListTile(
              friend: friend,
              addFriendButton: const SizedBox.shrink(),
          ),
        ),
      );
      listOfFriendsTile.add(const SizedBox(height: 20,));
    }

    return listOfFriendsTile;
  }
}