import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/auth_loading_bar.dart';

void main() {

  testWidgets('AuthLoadingBar renders correctly', (WidgetTester tester) async {

    await tester.pumpWidget(
      const MaterialApp(
        home: AuthLoadingBar(),
      ),
    );

    final containerWidget = tester.widget<Container>(find.byType(Container));
    expect(containerWidget.color, equals(Colors.transparent));

    expect(find.byType(SpinKitWave), findsOneWidget);

    final spinKitWaveWidget = tester.widget<SpinKitWave>(find.byType(SpinKitWave));
    expect(spinKitWaveWidget.color, equals(Colors.black));
    expect(spinKitWaveWidget.size, equals(32.0));
  });
}
