import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_button.dart';

void main() {

  testWidgets('AuthButton renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AuthButton(
          onTap: () {},
          text: 'Sign In',
        ),
      ),
    );

    expect(find.text('Sign In'), findsOneWidget);

    final textWidget = tester.widget<Text>(find.text('Sign In'));
    expect(textWidget.style?.color, equals(Colors.white));
    expect(textWidget.style?.fontWeight, equals(FontWeight.bold));
    expect(textWidget.style?.fontSize, equals(16.0));

    final containerWidget = tester.widget<Container>(find.byType(Container));
    expect(containerWidget.padding, equals(const EdgeInsets.all(25)));
    expect(containerWidget.margin, equals(const EdgeInsets.symmetric(horizontal: 25)));
    expect(containerWidget.decoration, equals(BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(8),
    )));
  });

  testWidgets('AuthButton onTap is called when tapped', (WidgetTester tester) async {
    bool isOnTapCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: AuthButton(
          onTap: () {
            isOnTapCalled = true;
          },
          text: 'Sign In',
        ),
      ),
    );

    await tester.tap(find.byType(AuthButton));
    await tester.pump();
    expect(isOnTapCalled, isTrue);
  });
}
