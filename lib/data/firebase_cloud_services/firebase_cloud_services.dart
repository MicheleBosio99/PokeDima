import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokedex_dima_new/application/deserializers/pokemon_cards_deserializer.dart';
import 'package:pokedex_dima_new/application/providers/pokemon_cards_provider.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/trade.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';
import 'package:provider/provider.dart';

class FirebaseCloudServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _cardsCollectionName = 'cards_collection';
  final String _usersCollectionName = 'users';
  final String _tradesCollectionName = 'trades';

  final String _cardsField = 'cards';
  final String _friendsUsernames = 'friendsUsernames';



  // CARDS COLLECTION METHODS
  Future<void> addPokemonCardToUser(String username, PokemonCard pokemonCard) async {
    try {
      var userDoc = await _firestore.collection(_cardsCollectionName).doc(username).get();
      if (userDoc.exists) {
        await _firestore.collection(_cardsCollectionName).doc(username).update({
          _cardsField: FieldValue.arrayUnion([pokemonCard.toJson()]),
        });
      } else {
        await _firestore.collection(_cardsCollectionName).doc(username).set({
          _cardsField: [pokemonCard.toJson()],
        });
      }
    } catch (error) {
      print('Error adding Pokemon card to Firestore: $error');
    }
  }

  Future<List<PokemonCard>> getPokemonCardsByUsername(String username) async {
    try {
      var userDoc = await _firestore.collection(_cardsCollectionName).doc(username).get();

      if (userDoc.exists) {
        var cards = userDoc.data()?[_cardsField] as List<dynamic>? ?? [];
        return cards.map((card) => PokemonCard.fromJson(card)).toList();
      } else {
        return [];
      }
    } catch (error) {
      print('Error getting Pokemon cards from Firestore: $error');
      return [];
    }
  }



  // USERS COLLECTION METHODS

  Future<void> addNewUserWithEmailAndUsername(String email, String username) async {
    try {
      CollectionReference usersCollection = FirebaseFirestore.instance.collection(_usersCollectionName);
      QuerySnapshot<Object?> existingUser = await usersCollection
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (existingUser.docs.isEmpty) {
        await usersCollection.add({
          'email': email,
          'username': username,
          'realName': username,
          'profilePictureUrl': 'https://firebasestorage.googleapis.com/v0/b/pokedexdima-new.appspot.com/o/_%24BaseFolder-PokeDima%2Fbase_profile_image?alt=media&token=18cc7205-f94a-428d-8d6c-ab6f11c72600',
          'bio': 'I am a new user!',
          'favouriteColor': '0xEEEEEEFF',
          'friendsUsernames': [],
          'accountCreationDate': '${_twoDigits(DateTime.now().day)}/${_twoDigits(DateTime.now().month)}/${DateTime.now().year}',
        });
      } else {
        return;
      }
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  Future<String?> getUsernameUsingEmail(String userEmail) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection(_usersCollectionName)
          .where('email', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String username = querySnapshot.docs[0].get('username');
        return username;
      } else {
        return null;
      }
    } catch (e) {
      print('Error retrieving username: $e');
      return null;
    }
  }

  Future<String?> getEmailUsingUsername(String username) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection(_usersCollectionName)
          .where('username', isEqualTo: username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String username = querySnapshot.docs[0].get('email');
        return username;
      } else {
        return null;
      }
    } catch (e) {
      print('Error retrieving email: $e');
      return null;
    }
  }

  Future<User?> getUserUsingUsername(String username) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(_usersCollectionName)
          .where('username', isEqualTo: username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return User(
          username: querySnapshot.docs[0].get('username'),
          email: querySnapshot.docs[0].get('email'),
          realName: querySnapshot.docs[0].get('realName'),
          profilePictureUrl: querySnapshot.docs[0].get('profilePictureUrl'),
          bio: querySnapshot.docs[0].get('bio'),
          favouriteColor: querySnapshot.docs[0].get('favouriteColor'),
          friendsUsernames: List<String>.from(querySnapshot.docs[0].get('friendsUsernames')),
          accountCreationDate: querySnapshot.docs[0].get('accountCreationDate'),
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Error retrieving user: $e');
      return null;
    }
  }

  Future<User?> getUserUsingEmail(String userEmail) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(_usersCollectionName)
          .where('email', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return User(
          username: querySnapshot.docs[0].get('username'),
          email: querySnapshot.docs[0].get('email'),
          realName: querySnapshot.docs[0].get('realName'),
          profilePictureUrl: querySnapshot.docs[0].get('profilePictureUrl'),
          bio: querySnapshot.docs[0].get('bio'),
          favouriteColor: querySnapshot.docs[0].get('favouriteColor'),
          friendsUsernames: List<String>.from(querySnapshot.docs[0].get('friendsUsernames')),
          accountCreationDate: querySnapshot.docs[0].get('accountCreationDate'),
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Error retrieving user: $e');
      return null;
    }
  }

  Future<List<User>> getUserFriendListFromUsername(String username) async {
    List<User> friendList = [];
    final friendUsernames = (await getUserUsingUsername(username))!.friendsUsernames;

    for(var friendUsername in friendUsernames) {
      final friend = await getUserUsingUsername(friendUsername);
      if(friend != null) { friendList.add(friend); }
    }

    return friendList;
  }

  void removeFriendOfUser(String username, String friendUsername) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(_usersCollectionName)
          .where('username', isEqualTo: username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> userDocument = querySnapshot.docs.first;
        List<String> currentFriends = List<String>.from(userDocument.get(_friendsUsernames));
        currentFriends.remove(friendUsername);

        await _firestore
            .collection(_usersCollectionName)
            .doc(userDocument.id)
            .update({_friendsUsernames: currentFriends});
      }
    } catch (e) {
      print('Error removing friend from user: $e');
    }
  }

  Future<void> addFriendWithUsername(String userUsername, String friendUsername) async {
    // TODO Send Notification to new friend


    if((await getUserFriendListFromUsername(userUsername)).any((friend) => friend.username == friendUsername)) { return; }

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(_usersCollectionName)
          .where('username', isEqualTo: userUsername)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> userDocument = querySnapshot.docs.first;
        List<String> currentFriends = List<String>.from(userDocument.get(_friendsUsernames));
        currentFriends.add(friendUsername);

        await _firestore
            .collection(_usersCollectionName)
            .doc(userDocument.id)
            .update({_friendsUsernames: currentFriends});
      }
    } catch (e) {
      print('Error removing friend from user: $e');
    }
  }

  Future<bool> isAlreadyFriend(String userUsername, String friendUsername) {
    return getUserFriendListFromUsername(userUsername).then((friendList) {
      for(var friend in friendList) { if(friend.username == friendUsername) { return true; } }
      return false;
    });
  }

  Future<void> updateUserByUsername(String username, User newUser) async {
    modifyCardsDocumentName(username, newUser.username);
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(_usersCollectionName)
          .where('username', isEqualTo: username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> userDocument = querySnapshot.docs.first;
        await _firestore
            .collection(_usersCollectionName)
            .doc(userDocument.id)
            .update(newUser.toJson());
      }
      return;
    } catch (e) {
      print('Error modifying user: $e');
    }
  }

  Future<void> modifyCardsDocumentName(String oldDocumentName, String newDocumentName) async {
    final CollectionReference collection = FirebaseFirestore.instance.collection(_cardsCollectionName);
    try {
      DocumentSnapshot oldDocumentSnapshot = await collection.doc(oldDocumentName).get();
      var data = oldDocumentSnapshot.data();

      if (data != null) {
        await collection.doc(newDocumentName).set(data);
        await collection.doc(oldDocumentName).delete();
        return;

      }
    } catch (e) {
      print('Error renaming document: $e');
    }
  }

  void updateUserFavouriteColor(String username, Color favouriteColor) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(_usersCollectionName)
          .where('username', isEqualTo: username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> userDocument = querySnapshot.docs.first;
        await _firestore
            .collection(_usersCollectionName)
            .doc(userDocument.id)
            .update({'favouriteColor': '0x${favouriteColor.value.toRadixString(16).toUpperCase().substring(2)}'});
      }

    } catch (e) {
      print('Error retrieving user: $e');
      return null;
    }
  }

  Future<List<Trade>> getAllUserTrades(String username) {
    return Future.wait([getTradesSentByUsername(username), getTradesProposedToUsername(username)])
        .then((List<List<Trade>> trades) {
      return trades[0] + trades[1];
    });
  }

  Future<List<Trade>> getTradesSentByUsername(String username) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('trades')
          .where('senderUsername', isEqualTo: username)
          .get();

      List<Trade> trades = [];
      for (var trade in querySnapshot.docs) {
        trades.add(Trade.fromJson(trade.data()));
      }
      return trades;
    } catch (e) {
      print('Error retrieving trades: $e');
      return [];
    }
  }

  Future<List<Trade>> getTradesProposedToUsername(String username) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(_tradesCollectionName)
          .where('receiverUsername', isEqualTo: username)
          .get();

      List<Trade> trades = [];
      for (var trade in querySnapshot.docs) {
        trades.add(Trade.fromJson(trade.data()));
      }
      return trades;
    } catch (e) {
      print('Error retrieving trades: $e');
      return [];
    }
  }

  void uploadNewTrade(Trade trade, List<PokemonCard> userPokemonCards, List<PokemonCard> friendPokemonCards) async {
    try {
      await _firestore.collection(_tradesCollectionName).add(trade.toJson());
      addPokemonCardsToTrade(trade.tradeId, userPokemonCards, friendPokemonCards);
    } catch (e) {
      print('Error uploading trade: $e');
    }
  }

  void addPokemonCardsToTrade(String tradeId, List<PokemonCard> userPokemonCards, List<PokemonCard> friendPokemonCards) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(_tradesCollectionName)
          .where('tradeId', isEqualTo: tradeId)
          .get();

      querySnapshot.docs.first.reference.update({
        'pokemonCardsOffered': userPokemonCards.map((card) => card.toJson()).toList(),
        'pokemonCardsRequested': friendPokemonCards.map((card) => card.toJson()).toList(),
      });
    } catch (e) {
      print('Error adding Pokemon cards to trade: $e');
    }
  }

  Future<bool> doesTradeBetweenUserAndFriendAlreadyExist(String userUsername, String friendUsername) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(_tradesCollectionName)
          .where('senderUsername', isEqualTo: userUsername)
          .where('receiverUsername', isEqualTo: friendUsername)
          .get();
      if (querySnapshot.docs.isNotEmpty) { return true; }

      querySnapshot = await _firestore
          .collection(_tradesCollectionName)
          .where('senderUsername', isEqualTo: friendUsername)
          .where('receiverUsername', isEqualTo: userUsername)
          .get();
      if (querySnapshot.docs.isNotEmpty) { return true; }

      return false;
    }
    catch (e) {
      print('Error findings trades: $e');
      return false;
    }
  }

  Future<List<Trade>> getAllTradesOfUser(String username) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(_tradesCollectionName)
          .where('senderUsername', isEqualTo: username)
          .get();
      List<Trade> trades = [];
      for (var trade in querySnapshot.docs) {trades.add(Trade.fromJson(trade.data()));}

      querySnapshot = await _firestore
          .collection(_tradesCollectionName)
          .where('receiverUsername', isEqualTo: username)
          .get();
      for (var trade in querySnapshot.docs) {trades.add(Trade.fromJson(trade.data()));}

      trades.sort((a, b) => DateTime.parse(b.timestamp).compareTo(DateTime.parse(a.timestamp)));
      return trades;
    } catch (e) {
      print('Error retrieving trades: $e');
      return [];
    }
  }

  Future<void> updateTradeStatus(Trade trade, String newStatus, { String email = "", BuildContext? context }) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(_tradesCollectionName)
          .where('tradeId', isEqualTo: trade.tradeId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> tradeDocument = querySnapshot.docs.first;
        await _firestore
            .collection(_tradesCollectionName)
            .doc(tradeDocument.id)
            .update({'status': newStatus});

        if(newStatus == "accepted") {
          _updateTradeStatusInCards(trade);
          PokemonCardsDeserializer.deserializeAndSetProviderData(email, Provider.of<PokemonCardsProvider>(context!, listen: false));
        }
      }
    } catch (e) {
      print('Error updating trade status: $e');
    }
  }

  void _updateTradeStatusInCards(Trade trade) {
    _removeCardsFromUser(trade.senderUsername, trade.pokemonCardsOffered);
    _removeCardsFromUser(trade.receiverUsername, trade.pokemonCardsRequested);

    _addCardsToUser(trade.senderUsername, trade.pokemonCardsRequested);
    _addCardsToUser(trade.receiverUsername, trade.pokemonCardsOffered);
  }

  void _addCardsToUser(String username, List<PokemonCard> cards) async {
    try {
      CollectionReference collectionReference = _firestore.collection(_cardsCollectionName);
      DocumentSnapshot documentSnapshot = await collectionReference.doc(username).get();

      if(documentSnapshot.exists) {
        await collectionReference.doc(username).update({
          _cardsField: FieldValue.arrayUnion(cards.map((card) => card.toJson()).toList()),
        });
      } else {
        await collectionReference.doc(username).set({
          _cardsField: cards.map((card) => card.toJson()).toList(),
        });
      }

    } catch (e) {
      print('Error adding cards to user: $e');
    }
  }

  void _removeCardsFromUser(String username, List<PokemonCard> cards) async {
    try {
      CollectionReference collectionReference = _firestore.collection(_cardsCollectionName);
      DocumentSnapshot documentSnapshot = await collectionReference.doc(username).get();

      if(documentSnapshot.exists) {
        await collectionReference.doc(username).update({
          _cardsField: FieldValue.arrayRemove(cards.map((card) => card.toJson()).toList()),
        });
      } else {
        await collectionReference.doc(username).set({
          _cardsField: cards.map((card) => card.toJson()).toList(),
        });
      }

    } catch (e) {
      print('Error adding cards to user: $e');
    }
  }

  Future<void> removeAllTradesWithUser(String userUsername, String friendUsername) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(_tradesCollectionName)
          .where('receiverUsername', isEqualTo: userUsername)
          .where('senderUsername', isEqualTo: friendUsername)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> tradeDocument = querySnapshot.docs.first;
        await _firestore
            .collection(_tradesCollectionName)
            .doc(tradeDocument.id)
            .delete();
      }

      querySnapshot = await _firestore
          .collection(_tradesCollectionName)
          .where('senderUsername', isEqualTo: userUsername)
          .where('receiverUsername', isEqualTo: friendUsername)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> tradeDocument = querySnapshot.docs.first;
        await _firestore
            .collection(_tradesCollectionName)
            .doc(tradeDocument.id)
            .delete();
      }
    } catch (e) {
      print('Error deleting trade: $e');
    }
  }

  Future<int> getNumberOfTradesAmongTwoUsers(String userUsername, String friendUsername) {
    return Future.wait([getTradesSentByUsername(userUsername), getTradesProposedToUsername(userUsername)])
        .then((List<List<Trade>> trades) {
      return trades[0].where((trade) => trade.receiverUsername == friendUsername).length +
          trades[1].where((trade) => trade.senderUsername == friendUsername).length;
    });
  }

  Future<void> deleteTrade(Trade trade) async {
    return _firestore.collection(_tradesCollectionName).where('tradeId', isEqualTo: trade.tradeId).get().then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.reference.delete();
      }
    });
  }

  Future<List<User>> getAllUserWithStringInUsername(String search) {
    return _firestore.collection(_usersCollectionName).where('username', isEqualTo: search).get().then((querySnapshot) {
      List<User> users = [];
      for (var user in querySnapshot.docs) {
        users.add(User(
          username: user.get('username'),
          email: user.get('email'),
          realName: user.get('realName'),
          profilePictureUrl: user.get('profilePictureUrl'),
          bio: user.get('bio'),
          favouriteColor: user.get('favouriteColor'),
          friendsUsernames: List<String>.from(user.get('friendsUsernames')),
          accountCreationDate: user.get('accountCreationDate'),
        ));
      }
      return users;
    });
  }
}