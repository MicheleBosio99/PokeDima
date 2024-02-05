import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/trade.dart';

void main() {
  group('FirebaseCloudServices Tests', () {
    late FirebaseCloudServices firebaseCloudServices;

    setUp(() {
      firebaseCloudServices = FirebaseCloudServices();
    });

    test('Get Stream Of Pokemon Cards By Username', () {
      // TODO: Prepare test data
      final username = 'testUser';

      // TODO: Call the method and test the stream
      final stream = firebaseCloudServices.getStreamOfPokemonCardsByUsername(username);
      // Add your assertions or use expectLater for stream testing
      // Example: expectLater(stream, emitsInOrder([expectedData]));

      // TODO: Additional test logic
    });

    test('Get User Friend List From Username', () async {
      // TODO: Prepare test data
      final username = 'testUser';

      // TODO: Call the method
      final friendList = await firebaseCloudServices.getUserFriendListFromUsername(username);

      // TODO: Check if the friend list is retrieved successfully
      expect(friendList, isList);
    });

    test('Remove Friend Of User', () async {
      // TODO: Prepare test data
      final username = 'testUser';
      final friendUsername = 'friendUser';

      // TODO: Call the method
      firebaseCloudServices.removeFriendOfUser(username, friendUsername);

      // TODO: Check if the friend is removed successfully
      final user = await firebaseCloudServices.getUserUsingUsername(username);
      expect(user!.friendsUsernames, isNot(contains(friendUsername)));
    });

    test('Add Friend With Username', () async {
      // TODO: Prepare test data
      final userUsername = 'testUser';
      final friendUsername = 'friendUser';

      // TODO: Call the method
      await firebaseCloudServices.addFriendWithUsername(userUsername, friendUsername);

      // TODO: Check if the friend is added successfully
      final user = await firebaseCloudServices.getUserUsingUsername(userUsername);
      expect(user!.friendsUsernames, contains(friendUsername));
    });

    test('Is Already Friend', () async {
      // TODO: Prepare test data
      final userUsername = 'testUser';
      final friendUsername = 'friendUser';

      // TODO: Call the method
      final isAlreadyFriend = await firebaseCloudServices.isAlreadyFriend(userUsername, friendUsername);

      // TODO: Check if the correct result is returned
      expect(isAlreadyFriend, isTrue);
    });

    test('Get All User Trades', () async {
      // TODO: Prepare test data
      final username = 'testUser';

      // TODO: Call the method
      final allTrades = await firebaseCloudServices.getAllUserTrades(username);

      // TODO: Check if the trades are retrieved successfully
      expect(allTrades, isList);
    });

    test('Get All Trades Of User', () async {
      // TODO: Prepare test data
      final username = 'testUser';

      // TODO: Call the method
      final userTrades = await firebaseCloudServices.getAllTradesOfUser(username);

      // TODO: Check if the trades are retrieved successfully
      expect(userTrades, isList);
    });

    test('Update Trade Status', () async {
      // TODO: Prepare test data
      final trade = Trade(
          tradeId: '123',
          senderUsername: 'user1',
          receiverUsername: 'user2',
          pokemonCardsOffered: [],
          pokemonCardsRequested: [],
          status: 'pending',
          timestamp: DateTime.now().toString()
      );
      final newStatus = 'accepted';

      // TODO: Call the method
      await firebaseCloudServices.updateTradeStatus(trade, newStatus);

      // TODO: Check if the trade status is updated successfully
      final updatedTrade = await firebaseCloudServices.getAllTradesOfUser(trade.senderUsername);
      expect(updatedTrade, isList);
      expect(updatedTrade.first.status, newStatus);
    });

    test('Delete Trade', () async {
      // TODO: Prepare test data
      final trade = Trade(
          tradeId: '123',
          senderUsername: 'user1',
          receiverUsername: 'user2',
          pokemonCardsOffered: [],
          pokemonCardsRequested: [],
          status: 'pending',
          timestamp: DateTime.now().toString()
      );

      final newStatus = '';

      // TODO: Call the method
      await firebaseCloudServices.deleteTrade(trade);

      // TODO: Check if the trade is deleted successfully
      final allTrades = await firebaseCloudServices.getAllTradesOfUser(trade.senderUsername);
      expect(allTrades, isNot(contains(trade)));
    });

    test('Get All User With String In Username', () async {
      // TODO: Prepare test data
      final search = 'test';

      // TODO: Call the method
      final users = await firebaseCloudServices.getAllUserWithStringInUsername(search);

      // TODO: Check if the users are retrieved successfully
      expect(users, isList);
    });

    // TODO: Add more test cases for other methods in the class
  });
}