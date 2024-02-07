import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/auth_services/auth_service.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/friend_list_page.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/user_profile_page.dart';



class MenuDrawer extends StatelessWidget {

  final Function changeBodyWidget;
  const MenuDrawer({ super.key, required this.changeBodyWidget });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      backgroundColor: Colors.grey[200],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Colors.grey[500]!,
                    width: 3,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(0),
              child: Image.asset('lib/images/logos/poke_dima_logo.png'),
            ),
          ),
        ],
      ),
    );
  }
}
