import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';

class PokemonProvider extends ChangeNotifier {
  List<Pokemon> _pokemonList = [];
  List<Pokemon> get pokemonList => _pokemonList;

  void setPokemonList(List<Pokemon> list) {
    _pokemonList = list;
    notifyListeners();
  }

  Pokemon? getPokemonById(String id) {
    return _pokemonList.firstWhere((pokemon) => pokemon.id == id);
  }
}