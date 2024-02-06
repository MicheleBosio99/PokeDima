import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';
import 'package:pokedex_dima_new/domain/pokemon_type.dart';

void main() {
  group('PokemonProvider Tests', () {
    late PokemonProvider provider;

    final Pokemon testPokemon = Pokemon(
      name: 'Bulbasaur',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/pokedexdima-new.appspot.com/o/_%24BaseFolder-PokeDima%2Fbulbasaur_test?alt=media&token=c2f67553-e570-413c-9802-54fcc24d1b5f',
      pokemonTypes: [PokemonType(name: "Grass", color: Colors.green[700]!, backgroundColor: Colors.green)],
      id: '#001',
      xDescription: '',
      height: '',
      weight: '',
      evolutions: [],
      hp: 100,
      attack: 0,
      defense: 0,
      specialAttack: 0,
      specialDefense: 0,
      speed: 0,
      evolvedFrom: '',
    );

    setUp(() {
      provider = PokemonProvider();
    });

    test('Initial state', () {
      expect(provider.pokemonList, isEmpty);
    });

    test('Add Pokemon to list', () {
      provider.addPokemonToList(testPokemon);
      expect(provider.pokemonList, contains(testPokemon));
    });

    test('Set Pokemon list', () {
      final pokemonList = [testPokemon, testPokemon, testPokemon];
      provider.setPokemonList(pokemonList);
      expect(provider.pokemonList, equals(pokemonList));
    });

    test('Get Pokemon by ID', () {
      provider.addPokemonToList(testPokemon);
      final retrievedPokemon = provider.getPokemonById('#001');
      expect(retrievedPokemon, equals(testPokemon));
    });

    test('Get Pokemon by name', () {
      provider.addPokemonToList(testPokemon);
      final retrievedPokemon = provider.getPokemonByName('Bulbasaur');
      expect(retrievedPokemon, equals(testPokemon));
    });
  });
}
