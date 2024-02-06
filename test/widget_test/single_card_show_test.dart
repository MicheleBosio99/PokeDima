import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';
import 'package:pokedex_dima_new/presentation/widgets/single_card_show.dart';

void main() {
  testWidgets('SingleCardShowImage renders correctly', (WidgetTester tester) async {

    const sampleCard = PokemonCard(
      id: '1',
      pokemonName: 'TestPokemon',
      rarity: 'Common',
      numInBatch: "5",
      imageUrl: '',
      stillOwned: true,
    );

    bool isChangeBodyWidgetCalled = false;

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleCardShowImage(
              card: sampleCard,
              changeBodyWidget: (page) => isChangeBodyWidgetCalled = true,
            ),
          ),
        ),
      );
    });

    expect(find.text('TestPokemon'), findsNothing);
    expect(find.text('-5-'), findsNothing);
    expect(find.text('Common'), findsNothing);

    await tester.tap(find.byType(ElevatedButton));
    expect(isChangeBodyWidgetCalled, false);

    await tester.longPress(find.byType(ElevatedButton));
    expect(isChangeBodyWidgetCalled, true);
  });
}