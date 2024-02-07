import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/presentation/phone/widgets/user_profile_square.dart';

void main() {

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

  testWidgets('UserProfileSquare renders correctly with custom background color', (WidgetTester tester) async {

    const Color customBackgroundColor = Colors.blue;
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserProfileSquare(user: sampleUser),
          ),
        ),
      );
    });

    expect(find.byType(UserProfileSquare), findsOneWidget);
    expect(find.text(sampleUser.username), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(Divider), findsOneWidget);
  });

  testWidgets('UserProfileSquare renders correctly without background color', (WidgetTester tester) async {

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserProfileSquare(user: sampleUser),
          ),
        ),
      );
    });

    expect(find.byType(UserProfileSquare), findsOneWidget);
    expect(find.text(sampleUser.username), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(Divider), findsOneWidget);
  });
}
