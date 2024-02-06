import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_dima_new/presentation/widgets/modify_info_text_field.dart';

void main() {
  testWidgets('ModifyProfileFormField renders correctly', (WidgetTester tester) async {

    final TextEditingController testController = TextEditingController();
    const String testHintText = 'Enter your information';

    await tester.pumpWidget(
      MaterialApp(
        home: ModifyProfileFormField(
          controller: testController,
          hintText: testHintText,
        ),
      ),
    );

    final paddingWidget = tester.widget<Padding>(find.byType(Padding));
    expect(paddingWidget.padding, equals(const EdgeInsets.symmetric(horizontal: 40, vertical: 5)));

    final textFormFieldWidget = tester.widget<TextFormField>(find.byType(TextFormField));
    expect(textFormFieldWidget.controller, equals(testController));
  });
}
