import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';


class PokemonCardsProvider extends ChangeNotifier {
  List<PokemonCard> _pokemonCardsList = [];
  List<PokemonCard> get pokemonCardsList => _pokemonCardsList;

  void setPokemonCardsList(List<PokemonCard> pokemonCards) {
    _pokemonCardsList = pokemonCards;
    notifyListeners();
  }

  void addPokemonCard(PokemonCard pokemonCard) {
    _pokemonCardsList.add(pokemonCard);
    notifyListeners();
  }

  // TODO: filters
}