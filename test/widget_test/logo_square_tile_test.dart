import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/logo_square_tile.dart';

void main() {
  testWidgets('LogoSquareTile renders correctly', (WidgetTester tester) async {

    const String testImagePath = 'lib/images/logos/poke_dima_logo.png';

    bool isTapped = false;
    void onTap() {
      isTapped = true;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: LogoSquareTile(
          imagePath: testImagePath,
          onTap: onTap,
        ),
      ),
    );

    final textButtonWidget = tester.widget<TextButton>(find.byType(TextButton));
    expect(textButtonWidget.onPressed, onTap);

    final containerWidget = tester.widget<Container>(find.byType(Container));
    expect(containerWidget.decoration, isA<Decoration>());
    expect(containerWidget.decoration, isA<BoxDecoration>());

    final imageWidget = tester.widget<Image>(find.byType(Image));
    expect(imageWidget.image, isA<AssetImage>());
    expect((imageWidget.image as AssetImage).assetName, equals(testImagePath));
    expect(imageWidget.height, equals(40));

    await tester.tap(find.byType(TextButton));
    await tester.pump();
    expect(isTapped, isTrue);
  });
}
