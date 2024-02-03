import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';
import 'package:pokedex_dima_new/presentation/pages/pokemon_card_info_page.dart';



class SingleCardShow extends StatelessWidget {

  final PokemonCard card;
  final Function changeBodyWidget;
  final double width;
  final double height;
  const SingleCardShow({ super.key, required this.card, required this.changeBodyWidget, this.width = 80, this.height = 120 });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
        ),
        onPressed: () { },
        onLongPress: () { changeBodyWidget(PokemonCardInfoPage(changeBodyWidget: changeBodyWidget, pokemonCard: card,)); },
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(card.imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey[800]!,
              width: 3,
            ),
          ),
        ),
      ),
    );
  }
}
