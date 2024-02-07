import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pokedex_dima_new/presentation/phone/pages/visualize_profile_image.dart';

void main() {
  group('VisualizeProfileImage', () {
    testWidgets('should change body widget on back button press', (WidgetTester tester) async {

      const imageUrl = 'https://example.com/image.jpg';
      bool changeBodyWidgetCalled = false;
      void changeBodyWidget() { changeBodyWidgetCalled = true; }

      final widget = VisualizeProfileImage(imageUrl: imageUrl, changeBodyWidget: changeBodyWidget);

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: widget),
          ),
        );
      });

      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_back_sharp));
      await tester.pumpAndSettle();

      expect(changeBodyWidgetCalled, isTrue);
    });
  });
}
