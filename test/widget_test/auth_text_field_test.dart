import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_dima_new/presentation/widgets/auth_text_field.dart';

void main() {
  testWidgets('AuthTextFormField renders correctly', (WidgetTester tester) async {

    final TextEditingController testController = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AuthTextFormField(
            controller: testController,
            hintText: 'Enter text',
            obscureText: false,
            validator: (value) => value.isEmpty ? 'Field cannot be empty' : null,
          ),
        ),
      ),
    );

    final paddingWidget = tester.widget<Padding>(find.byType(Padding));
    expect(paddingWidget.padding, equals(const EdgeInsets.symmetric(horizontal: 25.0)));

    expect(find.byType(AuthTextFormField), findsOneWidget);

    final textFormFieldWidget = tester.widget<AuthTextFormField>(find.byType(AuthTextFormField));

    expect(textFormFieldWidget.controller, equals(testController));
    expect(textFormFieldWidget.obscureText, isFalse);
    expect(textFormFieldWidget.validator, isA<Function>());
  });
}