import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';

class PokemonDeserializer {

  static Future<String> _loadJsonData() async {
    return await rootBundle.loadString('lib/data/json/pokemons.json');
  }

  static Future<void> deserializeAndSetProviderData(PokemonProvider pokemonProvider) async {
    final String jsonString = await _loadJsonData();
    final List<dynamic> jsonList = json.decode(jsonString);

    final List<Pokemon> pokemonList = jsonList
        .map((pokemon) => Pokemon.fromJson(pokemon as Map<String, dynamic>))
        .toList();

    pokemonProvider.setPokemonList(pokemonList);
  }
}