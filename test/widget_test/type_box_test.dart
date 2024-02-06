import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_dima_new/domain/pokemon_type.dart';
import 'package:pokedex_dima_new/presentation/widgets/type_box.dart';

void main() {
  testWidgets('Type Boxes widgets render correctly', (WidgetTester tester) async {

    final type1 = PokemonType(name: 'Type1', color: Colors.red, backgroundColor: Colors.white);
    final type2 = PokemonType(name: 'Type2', color: Colors.blue, backgroundColor: Colors.yellow);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: horizontalTypeBoxes([type1, type2]),
        ),
      ),
    );
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Column), findsNothing);


    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: verticalTypeBoxes([type1, type2]),
        ),
      ),
    );
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Row), findsNothing);


    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: weaknessBoxes([type1, type2]),
        ),
      ),
    );
    expect(find.byType(ListView), findsOneWidget);


    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: typeBox(type1),
        ),
      ),
    );
    expect(find.byType(Container), findsOneWidget);


    bool onPressedCalled = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: typeBoxWithButton(type1, (type) => onPressedCalled = true),
        ),
      ),
    );
    expect(find.byType(ElevatedButton), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    expect(onPressedCalled, isTrue);
  });
}
