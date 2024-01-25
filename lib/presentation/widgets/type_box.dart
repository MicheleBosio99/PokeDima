import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/domain/pokemon_type.dart';


Widget typeBoxes(List<PokemonType> types, {double distance = 0.0}) {
  return types.length == 1
      ? Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      typeBox(types[0]),
    ],
  )
      : Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      typeBox(types[0]),
      SizedBox(width: distance),
      typeBox(types[1]),
    ],
  );
}

Container typeBox(PokemonType type) {
  return Container(
    width: 60, // Adjust width as needed
    height: 25, // Adjust height as needed
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), color: type.color),
    child: Center(
      child: Text(
        type.name,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget weaknessBoxes(List<PokemonType> types) {
  return types.length == 1
      ? typeBox(types[0])
      : ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: types.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: typeBox(types[index]),
      );
    },
  );
}