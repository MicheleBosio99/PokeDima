import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/domain/user.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/friend_profile_page.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/auth_loading_bar.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/friend_list_tile.dart';
import 'package:pokedex_dima_new/presentation/tablet/pages/friend_profile_page_tablet.dart';
import 'package:provider/provider.dart';

class FriendList extends StatefulWidget {

  final Function changeBodyWidget;
  final bool isTablet;
  const FriendList({ required this.changeBodyWidget, this.isTablet = false });

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  late User user;
  late List<User> friendsFullList;

  final TextEditingController searchController = TextEditingController();
  User? userSearched;
  bool isFiltered = false;

  Future<void> _loadAsynchronousVariables(email) async {
    user = (await FirebaseCloudServices().getUserUsingEmail(email))!;
    friendsFullList = await FirebaseCloudServices().getUserFriendListFromUsername(user.username);
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 0, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: isFiltered ? () {
                            setState(() {
                              isFiltered = false;
                            });
                          } : null,
                          icon: const Icon(Icons.close),
                          iconSize: 30,
                          color: Colors.red[600],
                          disabledColor: Colors.grey[400],
                        ),

                        const SizedBox(width: 20,),

                        Container(
                          width: 180,
                          alignment: Alignment.center,
                          child: TextFormField(
                            onFieldSubmitted: (value) async  {
                              var userFound = await FirebaseCloudServices().getUserUsingUsername(searchController.text);
                              setState(() {
                                isFiltered = true;
                                userSearched = userFound;
                              });
                            },
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: "Search for a user...",
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
                            var userFound = await FirebaseCloudServices().getUserUsingUsername(searchController.text);
                            setState(() {
                              isFiltered = true;
                              userSearched = userFound;
                            });
                          },
                          icon: const Icon(Icons.search_outlined),
                          iconSize: 30,
                          color: Colors.grey[800],
                        ),
                      ],
                    ),
                  ),

                  Divider(
                    color: Colors.grey[800],
                    thickness: 2,
                    indent: 50,
                    endIndent: 50,
                  ),

                  const SizedBox(height: 22,),

                  if(!isFiltered && friendsFullList.isEmpty)
                    const Text("You have no friends yet."),

                  if(!isFiltered && friendsFullList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 20, top: 0, bottom: 10),
                      child: Container(
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Column(
                            children: _getListOfFriendsTile(friendsFullList, widget.changeBodyWidget, true),
                          ),
                        ),
                      ),
                    ),

                  if(isFiltered && userSearched == null)
                    const Text("No user was found."),

                  if(isFiltered && userSearched != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 20, top: 0, bottom: 10),
                      child: Container(
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Column(
                            children: _getListOfFriendsTile(
                              [userSearched!],
                              widget.changeBodyWidget,
                              friendsFullList.any((element) => element.username == userSearched!.username)
                            ),
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

  List<Widget> _getListOfFriendsTile(List<User> friends, Function changeBodyWidget, bool isAlreadyFriend) {
    List<Widget> listOfFriendsTile = [];
    for(var friend in friends) {
      listOfFriendsTile.add(
        GestureDetector(
          onTap: () {
            print(widget.isTablet);
            widget.changeBodyWidget(
              !widget.isTablet ?
              FriendProfile(changeBodyWidget: widget.changeBodyWidget, friend: friend, username: user.username,)
              : FriendProfileTablet(changeBodyWidget: widget.changeBodyWidget, friend: friend, username: user.username,),
              index: -1,
            );
          },
          child: FriendListTile(
              friend: friend,
              addFriendButton: isAlreadyFriend ? const SizedBox.shrink() :
              IconButton(
                onPressed: () async {
                  await FirebaseCloudServices().addFriendWithUsername(user.username, friend.username);
                  !widget.isTablet ? widget.changeBodyWidget(FriendList(changeBodyWidget: widget.changeBodyWidget), index: -1) :
                  widget.changeBodyWidget(FriendProfileTablet(friend: friend, username: user.username, changeBodyWidget: widget.changeBodyWidget), index: -1);
                },
                icon: const Icon(Icons.add_circle_outline_sharp),
                iconSize: 32,
                color: Colors.grey[800],
              ),
          ),
        ),
      );
      listOfFriendsTile.add(const SizedBox(height: 20,));
    }

    return listOfFriendsTile;
  }
}