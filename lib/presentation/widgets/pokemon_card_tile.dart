import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';
import 'package:pokedex_dima_new/presentation/pages/pokemon_card_info_page.dart';
import 'package:pokedex_dima_new/presentation/widgets/type_box.dart';
import 'package:provider/provider.dart';
import 'package:selectable_container/selectable_container.dart';

class PokemonCardTile extends StatefulWidget {

  final PokemonCard pokemonCard;
  final Function changeBodyWidget;
  final Function? onLongPressAdd;
  const PokemonCardTile({required this.pokemonCard, required this.changeBodyWidget, this.onLongPressAdd});

  @override
  State<PokemonCardTile> createState() => _PokemonCardTileState();
}

class _PokemonCardTileState extends State<PokemonCardTile> {
  bool isSelected = false;

  void toggleSelected() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final relativePokemon = Provider.of<PokemonProvider>(context, listen: false).getPokemonByName(widget.pokemonCard.pokemonName)!;

    return GestureDetector(
      onTap: () {
        widget.changeBodyWidget(PokemonCardInfoPage(
          pokemonCard: widget.pokemonCard,
          changeBodyWidget: widget.changeBodyWidget,
        ));
      },
      onLongPress: () {
        toggleSelected();
        widget.onLongPressAdd == null ? () {} : widget.onLongPressAdd!(widget.pokemonCard.id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,),
        child: SelectableContainer(
          selectedBorderColor: Colors.green[500],
          selectedBackgroundColor: relativePokemon.pokemonTypes[0].backgroundColor,
          unselectedBorderColor: Colors.grey[800],
          unselectedBackgroundColor: relativePokemon.pokemonTypes[0].backgroundColor,
          selectedBackgroundColorIcon: Colors.green[500],
          unselectedBackgroundColorIcon: Colors.grey[800],
          iconAlignment: Alignment.centerRight,
          icon: Icons.check,
          unselectedIcon: Icons.add,
          marginColor: Colors.transparent,
          elevation: 0,
          iconSize: 32,
          unselectedOpacity: 1,
          selectedOpacity: 0.8,
          selected: isSelected,
          padding: 8.0,
          borderSize: 3,
          borderRadius: 20,
          onValueChanged: (value) {
            widget.onLongPressAdd == null ? () {} : widget.onLongPressAdd!(widget.pokemonCard.id);
            setState(() {
              isSelected = value;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Row(
              children: [
                Image.network(
                  widget.pokemonCard.imageUrl,
                  height: 100,
                  width: 80,
                ),
                Column(
                  children: [
                    Text(
                      widget.pokemonCard.pokemonName,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.pokemonCard.numInBatch,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                verticalTypeBoxes(
                  relativePokemon.pokemonTypes,
                  distance: 20.0,
                ),
                const SizedBox(
                  width: 20,
                ),
                _getRarityIcon(widget.pokemonCard.rarity),
              ],
            ),
          )
        ),
      ),
    );
  }

  Icon _getRarityIcon(String rarity) {
    switch (rarity) {
      case "Common":
        return Icon(
          Icons.circle_outlined,
          color: Colors.grey[800],
          size: 32,
        );
      case "Uncommon":
        return Icon(
          Icons.circle,
          color: Colors.grey[800],
          size: 32,
        );
      case "Rare":
        return Icon(
          Icons.square_outlined,
          color: Colors.grey[800],
          size: 32,
        );
      case "Very Rare":
        return Icon(
          Icons.square,
          color: Colors.grey[800],
          size: 32,
        );
      case "Legendary":
        return Icon(
          Icons.star,
          color: Colors.orange[600],
          size: 32,
        );
      default:
        return Icon(
          Icons.circle_outlined,
          color: Colors.grey[800],
          size: 32,
        );
    }
  }
}

// GestureDetector(
// onTap: () {
// widget.changeBodyWidget(PokemonCardInfoPage(
// pokemonCard: widget.pokemonCard,
// changeBodyWidget: widget.changeBodyWidget,
// ));
// },
// onLongPress: () {
// toggleSelected();
// widget.onLongPressAdd == null ? () {} : widget.onLongPressAdd!(widget.pokemonCard.id);
// },
// child: Padding(
// padding: const EdgeInsets.all(10.0),
// child: Container(
// decoration: BoxDecoration(
// color: !isSelected ? relativePokemon.pokemonTypes[0].backgroundColor : Colors.yellow[200],
// borderRadius: BorderRadius.circular(20),
// border: !isSelected
// ? Border.all(
// color: Colors.grey[800]!,
// width: 5,
// )
//     : Border.all(
// color: Colors.deepPurple[200]!,
// width: 5,
// ),
// ),
// alignment: Alignment.center,
// child: Padding(
// padding: const EdgeInsets.all(10.0),
// child: Row(
// children: [
// Image.network(
// widget.pokemonCard.imageUrl,
// height: 100,
// width: 100,
// ),
// Column(
// children: [
// Text(
// widget.pokemonCard.pokemonName,
// style: TextStyle(
// color: Colors.grey[800],
// fontSize: 22.0,
// fontWeight: FontWeight.bold,
// ),
// ),
// const SizedBox(
// height: 5,
// ),
// Text(
// widget.pokemonCard.numInBatch,
// style: TextStyle(
// color: Colors.grey[800],
// fontSize: 18.0,
// fontWeight: FontWeight.bold,
// ),
// ),
// ],
// ),
// const SizedBox(
// width: 20,
// ),
// verticalTypeBoxes(
// relativePokemon.pokemonTypes,
// distance: 20.0,
// ),
// const SizedBox(
// width: 35,
// ),
// _getRarityIcon(widget.pokemonCard.rarity),
// ],
// ),
// ),
// ),
// ),
// );
