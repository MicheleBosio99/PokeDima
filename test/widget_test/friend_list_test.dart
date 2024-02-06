import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/presentation/widgets/friend_list_tile.dart';

void main() {
  testWidgets('FriendListTile renders correctly', (WidgetTester tester) async {

    const User testUser = User(
      username: 'user1test',
      favouriteColor: '0xEEEEEEFF',
      profilePictureUrl: 'https://example.com/test_user.jpg',
      email: 'test@test.test',
      realName: 'test tester',
      bio: 'this is a test',
      friendsUsernames: ["user2test"],
      accountCreationDate: '-1/-1/-111',
    );

    const Text testAddFriendButton = Text("hello");

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: FriendListTile(
            friend: testUser,
            addFriendButton: testAddFriendButton,
          ),
        ),
      );
    });

    final innerContainers = tester.widgetList<Container>(find.byType(Container).hitTestable());
    expect(innerContainers.toList()[0].decoration, isA<Decoration>());
    expect(innerContainers.toList()[1].decoration, isA<Decoration>());

    final rowWidget = tester.widget<Row>(find.byType(Row));
    expect(rowWidget.children, hasLength(6));

    final circleAvatarWidget = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
    expect(circleAvatarWidget.backgroundImage, isA<NetworkImage>());
    expect((circleAvatarWidget.backgroundImage as NetworkImage).url, equals(testUser.profilePictureUrl));

    final paddingWidget = (find.descendant(
        of: find.byType(Expanded),
        matching: find.byType(Padding),
        matchRoot: true,
    ).evaluate().single.widget as Padding);
    expect(paddingWidget.child, isA<Text>());
    expect((paddingWidget.child as Text).data, equals(testUser.username));

    expect(find.byWidget(testAddFriendButton), findsOneWidget);
  });
}
