import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';

class SingleCardShowImage extends StatelessWidget {

  final PokemonCard card;
  final Function changeBodyWidget;
  final double width;
  final double height;
  const SingleCardShowImage({ super.key, required this.card, required this.changeBodyWidget, this.width = 80, this.height = 120 });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey[800]!,
            width: 3,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage.assetNetwork(
            placeholder: 'lib/images/icons/bulbasaur_icon.png',
            fadeOutDuration: const Duration(milliseconds: 100),
            image: card.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
