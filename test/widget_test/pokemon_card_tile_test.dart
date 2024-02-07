import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_provider.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';
import 'package:pokedex_dima_new/domain/pokemon_type.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/pokemon_card_tile.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('PokemonCardTile renders correctly', (WidgetTester tester) async {
    final pokemonProvider = PokemonProvider();

    final samplePokemon = Pokemon(
      name: 'TestPokemon',
      imageUrl: 'https://example.com/test.png',
      pokemonTypes: [
        PokemonType(name: 'TypeA', color: Colors.blue, backgroundColor: Colors.blueAccent),
        PokemonType(name: 'TypeB', color: Colors.red, backgroundColor: Colors.redAccent),
      ],
      id: '1',
      xDescription: 'Description',
      height: '10',
      weight: '20',
      evolutions: ["#002"],
      hp: 100,
      attack: 50,
      defense: 30,
      specialAttack: 60,
      specialDefense: 40,
      speed: 70,
      evolvedFrom: '',
    );
    pokemonProvider.addPokemonToList(samplePokemon);

    const pokemonCard = PokemonCard(
      id: '1',
      pokemonName: 'TestPokemon',
      rarity: 'Common',
      numInBatch: "5",
      imageUrl: '',
      stillOwned: true,
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (context) => pokemonProvider,
              child: PokemonCardTile(
                pokemonCard: pokemonCard,
                changeBodyWidget: (page) {},
              ),
            ),
          ),
        ),
      );
    });

    expect(find.text('TestPokemon'), findsOneWidget);
    expect(find.text('-5-'), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
    expect(find.text('TypeA'), findsOneWidget);
    expect(find.text('TypeB'), findsOneWidget);
  });
}
