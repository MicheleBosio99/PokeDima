import 'package:flutter/material.dart';

class PokemonType {

  final String name;
  final Color color;
  final Color backgroundColor;

  PokemonType({required this.name, required this.color, required this.backgroundColor});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': color.value,
      'backgroundColor': backgroundColor.value,
    };
  }

  PokemonType getTypeFromJson(String typeName) {
    return PokemonType.fromJson(typeName);
  }

  factory PokemonType.fromJson(String typeName) {
    Color typeColor = _getColorForType(typeName);
    Color backgroundTypeColor = _getBackgroundColorForType(typeName);
    return PokemonType(name: typeName, color: typeColor, backgroundColor: backgroundTypeColor);
  }
}

Color _getColorForType(String typeName) {
Map<String, Color> typeColorMap = {
"Normal": const Color(0xFFD8D8D8), // Light Grey
"Fire": const Color(0xFFEF6F55), // Salmon
"Water": const Color(0xFF7AA7C2), // Sky Blue
"Grass": const Color(0xFF9BC88E), // Pastel Green
"Flying": const Color(0xFFC4C4C4), // Silver
"Fighting": const Color(0xFFCF6F61), // Pastel Red
"Poison": const Color(0xFF9D71D7), // Lavender
"Electric": const Color(0xFFF2D74E), // Pastel Yellow
"Ground": const Color(0xFFBF953F), // Camel
"Rock": const Color(0xFFB09F8E), // Pastel Brown
"Psychic": const Color(0xFFE59ED7), // Pastel Pink
"Ice": const Color(0xFFA5F1F9), // Baby Blue
"Bug": const Color(0xFFC4CC7A), // Pastel Olive
"Ghost": const Color(0xFF6D76B4), // Periwinkle
"Steel": const Color(0xFFA9A9A9), // Dark Gray
"Dragon": const Color(0xFF6A7A89), // Slate Blue
"Dark": const Color(0xFF5A4A42), // Chocolate
"Fairy": const Color(0xFFF2B6CF), // Pastel Pink
};

return typeColorMap[typeName] ?? Colors.grey;
}

Color _getBackgroundColorForType(String typeName) {
Map<String, Color> typeColorMap = {
"Normal": const Color(0xFFEEEEEE), // Light Grey
"Fire": const Color(0xFFFFC8A4), // Salmon
"Water": const Color(0xFFC8EEFF), // Sky Blue
"Grass": const Color(0xFFD3FBE8), // Pastel Green
"Flying": const Color(0xFF000000), // Silver
"Fighting": const Color(0xFFE6A3A3), // Pastel Red
"Poison": const Color(0xFFD2BFE5), // Lavender
"Electric": const Color(0xFFFFFB9A), // Pastel Yellow
"Ground": const Color(0xACFFDCAF), // Camel
"Rock": const Color(0xACF9E5DE), // Pastel Brown
"Psychic": const Color(0xFFE2BFED), // Pastel Pink
"Ice": const Color(0xFFE8F8FE), // Baby Blue
"Bug": const Color(0xFFDAFFC2), // Pastel Olive
"Ghost": const Color(0xFFAFB7D2), // Periwinkle
"Steel": const Color(0xFFBEC6C6), // Dark Gray
"Dragon": const Color(0xFFA2A9D0), // Slate Blue
"Dark": const Color(0xFFA4A495), // Chocolate GG
"Fairy": const Color(0xFFFCDEEC), // Pastel Pink
};

return typeColorMap[typeName] ?? Colors.grey;
}