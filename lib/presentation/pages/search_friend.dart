import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/domain/user.dart';
import 'package:pokedex_dima_new/presentation/pages/friend_list_page.dart';
import 'package:pokedex_dima_new/presentation/pages/friend_profile_page.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_loading_bar.dart';
import 'package:pokedex_dima_new/presentation/widgets/friend_list_tile.dart';
import 'package:provider/provider.dart';

class SearchFriend extends StatefulWidget {
  final Function changeBodyWidget;
  const SearchFriend({required this.changeBodyWidget});

  @override
  State<SearchFriend> createState() => _SearchFriendState();
}

class _SearchFriendState extends State<SearchFriend> {
  final TextEditingController _searchController = TextEditingController();
  late User user;
  Widget? friendWidget;
  User? foundUserFriend;

  Future<void> _loadAsynchronousVariables(email) async {
    user = (await FirebaseCloudServices().getUserUsingEmail(email))!;
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () { widget.changeBodyWidget(FriendList(changeBodyWidget: widget.changeBodyWidget), index: -1); },
                          icon: const Icon(Icons.arrow_back_sharp),
                          iconSize: 30,
                          color: Colors.grey[800],
                        ),

                        const SizedBox(width: 20,),

                        Container(
                          width: 180,
                          alignment: Alignment.center,
                          child: TextFormField(
                            onFieldSubmitted: (value) async {
                              var fw = await _getFriendWidget(user.username, _searchController.text);
                              setState(() {
                                friendWidget = fw;
                              });
                            },
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: "Search for a friend...",
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
                          onPressed: () async {
                            var fw = await _getFriendWidget(user.username, _searchController.text);
                            setState(() {
                              friendWidget = fw;
                            });
                          },
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: friendWidget,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  Future<Widget> _getFriendWidget(String userUsername, String friendUsername) async {
    bool isAlreadyFriend = await FirebaseCloudServices().isAlreadyFriend(userUsername, friendUsername);

    if (friendUsername == "" || userUsername == friendUsername) {
      return const SizedBox.shrink();
    } else {
      User? friend = await FirebaseCloudServices().getUserUsingUsername(friendUsername);
      if (friend != null) {
        return GestureDetector(
          onTap: () {
            widget.changeBodyWidget(FriendProfile(changeBodyWidget: widget.changeBodyWidget, friend: friend, username: userUsername), index: -1);
          },
          child: FriendListTile(
            friend: friend,
            addFriendButton: isAlreadyFriend ? const SizedBox.shrink() :
            IconButton(
              onPressed: () async {
                FirebaseCloudServices().addFriendWithUsername(userUsername, friendUsername);
                setState(() {
                  friendWidget = const SizedBox.shrink();
                });
              },
              icon: const Icon(Icons.add_circle_outline_sharp),
              iconSize: 32,
              color: Colors.grey[800],
            ),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
              border: Border.all(
                color: Colors.grey[800]!,
                width: 2,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              "User ${friendUsername} not found.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
    }
  }
}
