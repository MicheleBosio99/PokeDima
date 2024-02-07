import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/trade.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/trade_tile.dart';

void main() {
  testWidgets('TradeTile renders correctly', (WidgetTester tester) async {

    const User sampleUser = User(
      username: 'user1test',
      favouriteColor: '0xEEEEEEFF',
      profilePictureUrl: 'https://example.com/test_user.jpg',
      email: 'test@test.test',
      realName: 'test tester',
      bio: 'this is a test',
      friendsUsernames: ["user2test"],
      accountCreationDate: '-1/-1/-111',
    );

    const sampleTrade = Trade(
      tradeId: '1234',
      senderUsername: 'SenderUser',
      receiverUsername: 'ReceiverUser',
      status: 'accepted',
      pokemonCardsOffered: [],
      pokemonCardsRequested: [],
      timestamp: '',
    );

    bool isChangeBodyWidgetCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TradeTile(
            trade: sampleTrade,
            changeBodyWidget: (page) => isChangeBodyWidgetCalled = true,
            user: sampleUser,
          ),
        ),
      ),
    );

    expect(find.text('1234'), findsOneWidget);
    expect(find.text('SenderUser'), findsOneWidget);
    expect(find.text('ReceiverUser'), findsOneWidget);
    expect(find.byIcon(Icons.check_box_outlined), findsOneWidget);

    await tester.tap(find.byType(TextButton));
    expect(isChangeBodyWidgetCalled, isTrue);
  });
}
