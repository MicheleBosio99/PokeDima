import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/user_profile_page.dart';


class VisualizeProfileImage extends StatelessWidget {

  final String imageUrl;
  final Function changeBodyWidget;
  const VisualizeProfileImage({ super.key, required this.imageUrl, required this.changeBodyWidget });

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.grey[850],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 5,),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  size: 32,
                  color: Colors.white,
                ),
                onPressed: () { changeBodyWidget(UserProfile(changeBodyWidget: changeBodyWidget)); },
              ),
            ],
          ),

          const SizedBox(height: 20,),

          Center(
            child: Align(
              alignment: Alignment.center,
              child: Image.network(
                imageUrl,
                width: 800,
                scale: 0.8
                // fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
