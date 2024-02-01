import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';



class FriendListTile extends StatelessWidget {

  final User friend;
  final Widget addFriendButton;
  const FriendListTile({ required this.friend, required this.addFriendButton });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Color(int.parse(friend.favouriteColor)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(width: 10,),

            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.grey[800]!,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(friend.profilePictureUrl),
                radius: 40,
              ),
            ),

            const SizedBox(width: 40,),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Text(
                  friend.username,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 32,),

            addFriendButton,
          ],
        ),
      ),
    );
  }
}
