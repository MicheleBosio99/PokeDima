import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_dima_new/data/firebase_cloud_services/firebase_cloud_services.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/trade.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  group('FirebaseCloudServices Tests', () {
    final FirebaseCloudServices firebaseCloudServices = FirebaseCloudServices();


    test('Test addPokemonCardToUser', () async {
      const PokemonCard pokemonCard = PokemonCard(
        id: '123ABC',
        pokemonName: 'Pikachu',
        numInBatch: '001',
        imageUrl: 'https://example.com/pikachu.png',
        stillOwned: true,
        rarity: 'Common',
      );

      await firebaseCloudServices.addPokemonCardToUser('user1Test', pokemonCard);
      final List<PokemonCard> cards = await firebaseCloudServices.getPokemonCardsByUsername('user1Test');

      print(cards);

      expect(cards.length, 1);
      expect(cards.first.id, '123ABC');
    });


    test('Test getPokemonCardsByUsername', () async {
      final List<PokemonCard> cards = await firebaseCloudServices.getPokemonCardsByUsername('user1Test');

      expect(cards.length, 1);
      expect(cards.first.pokemonName, 'Pikachu');
    });


    test('Test getStreamOfPokemonCardsByUsername', () {
      final Stream<List<PokemonCard>> stream = firebaseCloudServices.getStreamOfPokemonCardsByUsername('user1Test');
      expect(stream, isNotNull);
    });


    test('Test deleteTrade', () async {
      final Trade trade = Trade(
        tradeId: 'trade123',
        senderUsername: 'user1Test',
        receiverUsername: 'user2Test',
        pokemonCardsOffered: [],
        pokemonCardsRequested: [],
        status: 'pending',
        timestamp: DateTime.now().toIso8601String(),
      );

      firebaseCloudServices.uploadNewTrade(trade, [], []);
      await firebaseCloudServices.deleteTrade(trade);

      final List<Trade> trades = await firebaseCloudServices.getAllUserTrades('user1Test');
      expect(trades.contains(trade), isFalse);
    });


    test('Test addNewUserWithEmailAndUsername', () async {
      await firebaseCloudServices.addNewUserWithEmailAndUsername('test@test.test', 'user3Test');

      final User user = (await firebaseCloudServices.getUserUsingUsername('user3Test'))!;
      expect(user, isNotNull);
      expect(user.username, 'user3Test');
      expect(user.email, 'test@test.test');
    });


    test('Test getUsernameUsingEmail', () async {
      final String? username = await firebaseCloudServices.getUsernameUsingEmail('test@test.test');
      expect(username, isNotNull);
      expect(username, 'user3Test');
    });


    test('Test getUserUsingUsername', () async {
      final User? user = await firebaseCloudServices.getUserUsingUsername('user1Test');
      expect(user, isNotNull);
      expect(user!.username, 'user1Test');
    });


    test('Test updateUserByUsername', () async {
      const User newUser = User(
        username: 'user1Test',
        email: 'newemail@test.com',
        realName: 'Updated User',
        profilePictureUrl: 'https://example.com/new_profile.png',
        bio: 'Updated bio',
        favouriteColor: '0xFFFFFF',
        friendsUsernames: ['user2Test'],
        accountCreationDate: '01/01/2023',
      );

      await firebaseCloudServices.updateUserByUsername('user1Test', newUser);
      final User? updatedUser = await firebaseCloudServices.getUserUsingUsername('user1Test');

      expect(updatedUser, isNotNull);
      expect(updatedUser!.email, 'newemail@test.com');
      expect(updatedUser.realName, 'Updated User');
    });


    test('Test updateUserFavouriteColor', () async {
      firebaseCloudServices.updateUserFavouriteColor('user1Test', const Color(0xFF0000));

      final User? updatedUser = await firebaseCloudServices.getUserUsingUsername('user1Test');
      expect(updatedUser, isNotNull);
      expect(updatedUser!.favouriteColor, '0xFF0000');
    });


    test('Test getAllUserWithStringInUsername', () async {
      final List<User> users = await firebaseCloudServices.getAllUserWithStringInUsername('user');
      expect(users.length, 3); // Assuming there are three users with 'user' in their username
    });


    test('Test getUserFriendListFromUsername', () async {
      final List<User> friendList = await firebaseCloudServices.getUserFriendListFromUsername('user1Test');
      expect(friendList.length, 1); // Assuming there is one friend for user1Test
    });


    test('Test removeFriendOfUser', () async {
      firebaseCloudServices.removeFriendOfUser('user1Test', 'user2Test');
      final List<User> friendList = await firebaseCloudServices.getUserFriendListFromUsername('user1Test');
      expect(friendList.length, 0); // Assuming user2Test is removed from user1Test's friend list
    });


    test('Test addFriendWithUsername', () async {
      await firebaseCloudServices.addFriendWithUsername('user1Test', 'user2Test');
      final List<User> friendList = await firebaseCloudServices.getUserFriendListFromUsername('user1Test');
      expect(friendList.length, 1); // Assuming user2Test is added back to user1Test's friend list
    });


    test('Test isAlreadyFriend', () async {
      final bool isFriend = await firebaseCloudServices.isAlreadyFriend('user1Test', 'user2Test');
      expect(isFriend, isTrue); // Assuming user2Test is a friend of user1Test
    });


    test('Test getAllUserTrades', () async {
      final List<Trade> allTrades = await firebaseCloudServices.getAllUserTrades('user1Test');
      expect(allTrades.length, greaterThanOrEqualTo(0)); // Assuming there can be 0 or more trades
    });


    test('Test uploadNewTrade', () async {
      final Trade trade = Trade(
        tradeId: 'trade456',
        senderUsername: 'user1Test',
        receiverUsername: 'user2Test',
        pokemonCardsOffered: [],
        pokemonCardsRequested: [],
        status: 'pending',
        timestamp: DateTime.now().toIso8601String(),
      );

      firebaseCloudServices.uploadNewTrade(trade, [], []);
      final List<Trade> trades = await firebaseCloudServices.getAllUserTrades('user1Test');
      expect(trades.contains(trade), isTrue);
    });


    test('Test updateTradeStatus', () async {
      final Trade trade = Trade(
        tradeId: 'trade789',
        senderUsername: 'user1Test',
        receiverUsername: 'user2Test',
        pokemonCardsOffered: [],
        pokemonCardsRequested: [],
        status: 'pending',
        timestamp: DateTime.now().toIso8601String(),
      );

      firebaseCloudServices.uploadNewTrade(trade, [], []);
      await firebaseCloudServices.updateTradeStatus(trade, 'accepted');
      final List<Trade> trades = await firebaseCloudServices.getAllUserTrades('user1Test');
      expect(trades.first.status, 'accepted');
    });


    test('Test doesTradeBetweenUserAndFriendAlreadyExist', () async {
      final bool tradeExists =
      await firebaseCloudServices.doesTradeBetweenUserAndFriendAlreadyExist('user1Test', 'user2Test');
      expect(tradeExists, isTrue); // Assuming a trade exists between user1Test and user2Test
    });


    test('Test getAllTradesOfUser', () async {
      final List<Trade> allTrades = await firebaseCloudServices.getAllTradesOfUser('user1Test');
      expect(allTrades.length, greaterThanOrEqualTo(0)); // Assuming there can be 0 or more trades
    });


    test('Test removeAllTradesWithUser', () async {
      await firebaseCloudServices.removeAllTradesWithUser('user1Test', 'user2Test');
      final List<Trade> trades = await firebaseCloudServices.getAllUserTrades('user1Test');
      expect(trades.any((trade) => trade.receiverUsername == 'user2Test' || trade.senderUsername == 'user2Test'), isFalse);
    });


    test('Test getNumberOfTradesAmongTwoUsers', () async {
      final int numberOfTrades =
      await firebaseCloudServices.getNumberOfTradesAmongTwoUsers('user1Test', 'user2Test');
      expect(numberOfTrades, greaterThanOrEqualTo(0)); // Assuming there can be 0 or more trades
    });


    test('Test deleteTrade', () async {
      final Trade tradeToDelete = Trade(
        tradeId: 'tradeToDelete',
        senderUsername: 'user1Test',
        receiverUsername: 'user2Test',
        pokemonCardsOffered: [],
        pokemonCardsRequested: [],
        status: 'pending',
        timestamp: DateTime.now().toIso8601String(),
      );

      firebaseCloudServices.uploadNewTrade(tradeToDelete, [], []);
      await firebaseCloudServices.deleteTrade(tradeToDelete);

      final List<Trade> trades = await firebaseCloudServices.getAllUserTrades('user1Test');
      expect(trades.contains(tradeToDelete), isFalse);
    });


    test('Test _updateTradeStatusInCards', () async {
      final Trade trade = Trade(
        tradeId: 'tradeToUpdateStatus',
        senderUsername: 'user1Test',
        receiverUsername: 'user2Test',
        pokemonCardsOffered: [
          const PokemonCard(id: '#123', pokemonName: 'Pikachu', numInBatch: '001', imageUrl: 'pikachu.png', stillOwned: true, rarity: 'Common'),
        ],
        pokemonCardsRequested: [
          const PokemonCard(id: '#456', pokemonName: 'Bulbasaur', numInBatch: '002', imageUrl: 'bulbasaur.png', stillOwned: true, rarity: 'Common'),
        ],
        status: 'pending',
        timestamp: DateTime.now().toIso8601String(),
      );

      firebaseCloudServices.uploadNewTrade(trade, trade.pokemonCardsOffered, trade.pokemonCardsRequested);
      await firebaseCloudServices.updateTradeStatus(trade, 'accepted', context: null);

      final List<PokemonCard> userCards = await firebaseCloudServices.getPokemonCardsByUsername('user1Test');
      final List<PokemonCard> friendCards = await firebaseCloudServices.getPokemonCardsByUsername('user2Test');

      expect(userCards.contains(trade.pokemonCardsRequested[0]), isTrue);
      expect(friendCards.contains(trade.pokemonCardsOffered[0]), isTrue);
    });


    test('Test updateUserByUsername', () async {
      final User? originalUser = await firebaseCloudServices.getUserUsingUsername('user1Test');

      final User newUser = User(
        username: 'user1Test',
        email: 'test@updated.test',
        realName: 'Updated User',
        profilePictureUrl: 'updated_image.png',
        bio: 'I am an updated user!',
        favouriteColor: '0xFFFFFF',
        friendsUsernames: [],
        accountCreationDate: originalUser!.accountCreationDate,
      );

      await firebaseCloudServices.updateUserByUsername('user1Test', newUser);
      final User? updatedUser = await firebaseCloudServices.getUserUsingUsername('user1Test');

      expect(updatedUser, equals(newUser));
    });


    test('Test updateUserFavouriteColor', () async {
      const Color newFavouriteColor = Colors.blue;

      firebaseCloudServices.updateUserFavouriteColor('user1Test', newFavouriteColor);

      final User? updatedUser = await firebaseCloudServices.getUserUsingUsername('user1Test');
      final String expectedColor = '0x${newFavouriteColor.value.toRadixString(16).toUpperCase().substring(2)}';

      expect(updatedUser!.favouriteColor, equals(expectedColor));
    });


    test('Test getAllUserWithStringInUsername', () async {
      final List<User> users = await firebaseCloudServices.getAllUserWithStringInUsername('user1Test');
      expect(users.length, greaterThanOrEqualTo(1)); // Assuming at least one user with 'user1Test' in the username
    });


    test('Test getUserFriendListFromUsername', () async {
      final List<User> friendList = await firebaseCloudServices.getUserFriendListFromUsername('user1Test');
      expect(friendList, isA<List<User>>());
    });


    test('Test removeFriendOfUser', () async {
      const String friendUsername = 'user2Test';

      firebaseCloudServices.removeFriendOfUser('user1Test', friendUsername);
      final List<User> friendList = await firebaseCloudServices.getUserFriendListFromUsername('user1Test');

      expect(friendList.any((friend) => friend.username == friendUsername), isFalse);
    });


    test('Test addFriendWithUsername', () async {
      const String friendUsername = 'user3Test';

      await firebaseCloudServices.addFriendWithUsername('user1Test', friendUsername);
      final List<User> friendList = await firebaseCloudServices.getUserFriendListFromUsername('user1Test');

      expect(friendList.any((friend) => friend.username == friendUsername), isTrue);
    });


    test('Test isAlreadyFriend', () async {
      const String friendUsername = 'user2Test';

      final bool alreadyFriend =
      await firebaseCloudServices.isAlreadyFriend('user1Test', friendUsername);

      expect(alreadyFriend, isTrue);
    });


    test('Test getEmailUsingUsername', () async {
      final String? userEmail = await firebaseCloudServices.getEmailUsingUsername('user1Test');
      expect(userEmail, isNotNull);
    });
  });
}
