import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';
import 'package:pokedex_dima_new/domain/pokemon_type.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/pokemon_tile.dart';

void main() {

  final Pokemon testPokemon = Pokemon(
    name: 'Bulbasaur',
    imageUrl: 'https://firebasestorage.googleapis.com/v0/b/pokedexdima-new.appspot.com/o/_%24BaseFolder-PokeDima%2Fbulbasaur_test?alt=media&token=c2f67553-e570-413c-9802-54fcc24d1b5f',
    pokemonTypes: [PokemonType(name: "Grass", color: Colors.green[700]!, backgroundColor: Colors.green)],
    id: '',
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
    evolvedFrom: '#001',
  );

  testWidgets('PokemonTile renders correctly', (WidgetTester tester) async {

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: PokemonTile(
            pokemon: testPokemon,
            changeBodyWidget: (widget) {},
          ),
        ),
      );
    });

    expect(find.text('Bulbasaur'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is Image), findsOneWidget);
  });

  testWidgets('PokemonTile onTap calls changeBodyWidget', (WidgetTester tester) async {
    bool isChangeBodyWidgetCalled = false;

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: PokemonTile(
            pokemon: testPokemon,
            changeBodyWidget: (widget) { isChangeBodyWidgetCalled = true; },
          ),
        ),
      );
    });

    await tester.tap(find.byType(PokemonTile));
    await tester.pump();
    expect(isChangeBodyWidgetCalled, isTrue);
  });
}