import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/domain/pokemon_type.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/type_box.dart';

class PokemonSelectableType extends StatefulWidget {

  final PokemonType type;
  final List<String> filterListRef;
  PokemonSelectableType({super.key, required this.type, required this.filterListRef});

  @override
  _PokemonSelectableTypeState createState() => _PokemonSelectableTypeState();
}

class _PokemonSelectableTypeState extends State<PokemonSelectableType> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    isSelected = widget.filterListRef.contains(widget.type.name);
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          if (isSelected) {
            if (!widget.filterListRef.contains(widget.type.name)) {
              widget.filterListRef.add(widget.type.name);
            }
          } else {
            widget.filterListRef.remove(widget.type.name);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD5E0E0) : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: typeBox(
            PokemonType.fromJson(widget.type.name),
          ),
        ),
      ),
    );
  }
}
