import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonProvider extends ChangeNotifier {
  List<Pokemon> _pokemonList = [];
  List<Pokemon> get pokemonList => _pokemonList;

  void resetPokemonList() {
    _pokemonList = [];
    notifyListeners();
  }

  void setPokemonList(List<Pokemon> list) {
    _pokemonList = list;
    notifyListeners();
  }

  Pokemon? getPokemonById(String id) {
    return _pokemonList.firstWhere((pokemon) => pokemon.id == id);
  }

  Pokemon? getPokemonByName(String name) {
    return _pokemonList.firstWhere((pokemon) => pokemon.name == name);
  }

  void filterPokemonListByTypes(List<String> pokemonWantedTypes) {
    _pokemonList = _pokemonList.where((pokemon) =>
        pokemon.pokemonTypes.any((type)
        => pokemonWantedTypes.contains(type.name)))
        .toList();
  }

  void filterPokemonListByWeaknesses(List<String> pokemonWantedWeaknesses) {
    _pokemonList = _pokemonList.where((pokemon) =>
        pokemon.weaknesses.any((type)
        => pokemonWantedWeaknesses.contains(type.name)))
        .toList();
  }

  Future<void> filterPokemonListByFavourites() async {
    final favList = await loadFavourites();
    _pokemonList = _pokemonList.where((pokemon) =>
        favList.contains(pokemon.name))
        .toList();
  }

  Future<List<String>> loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final serializedList = prefs.getString('favouritePokemonsList') ?? '';
    return serializedList.split(';');
  }
}