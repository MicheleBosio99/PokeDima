import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_cards_provider.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';

void main() {
  group('PokemonCardsProvider Tests', () {
    late PokemonCardsProvider provider;

    const pokemonCard1 = PokemonCard(
      id: '#001',
      pokemonName: 'Bulbasaur',
      rarity: 'Common',
      numInBatch: "1",
      imageUrl: '',
      stillOwned: true,
    );

    const pokemonCard2 = PokemonCard(
      id: '#002',
      pokemonName: 'Squirtle',
      rarity: 'Legendary',
      numInBatch: "5",
      imageUrl: '',
      stillOwned: true,
    );

    setUp(() {
      provider = PokemonCardsProvider();
    });

    test('Initial state', () {
      expect(provider.pokemonCardsList, isEmpty);
    });

    test('Reset PokemonCardsList', () {
      provider.setPokemonCardsList([pokemonCard1, pokemonCard2]);
      expect(provider.pokemonCardsList, isNotEmpty);
      provider.resetPokemonCardsList();
      expect(provider.pokemonCardsList, isEmpty);
    });

    test('Set PokemonCardsList', () {
      provider.setPokemonCardsList([pokemonCard1, pokemonCard2]);
      expect(provider.pokemonCardsList, containsAllInOrder([pokemonCard1, pokemonCard2]));
    });

    test('Add PokemonCard', () {
      provider.addPokemonCard(pokemonCard1);
      expect(provider.pokemonCardsList, contains(pokemonCard1));
    });

    test('Get PokemonCard by Id', () {
      provider.addPokemonCard(pokemonCard1);

      final retrievedCard = provider.getPokemonCardById('#001');
      expect(retrievedCard, equals(pokemonCard1));
    });

    test('Get PokemonCard by PokemonName', () {
      provider.addPokemonCard(pokemonCard1);
      final retrievedCard = provider.getPokemonCardByPokemonName('Bulbasaur');
      expect(retrievedCard, equals(pokemonCard1));
    });
  });
}