import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';



class UserProfileSquare extends StatelessWidget {

  final User user;
  final Color? backgroundColor;
  const UserProfileSquare({ super.key, required this.user, this.backgroundColor });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        color: backgroundColor ?? Color(int.parse(user.favouriteColor)),
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(
        //   color: Colors.grey[800]!,
        //   width: 2,
        // ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: Colors.grey[800]!,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(user.profilePictureUrl,),
              radius: 40,
            ),
          ),
          Text(
            user.username,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            color: Colors.grey[800],
            height: 2,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          )
        ],
      ),
    );
  }
}
