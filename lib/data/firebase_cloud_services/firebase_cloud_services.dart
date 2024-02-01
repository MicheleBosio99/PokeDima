import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokedex_dima_new/domain/firebase_cloud/user.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';

class FirebaseCloudServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _cardsCollection = 'cards_collection';
  final String _cardsField = 'cards';
  final String _usersCollectionName = 'users';
  final String _friendsUsernames = 'friendsUsernames';

  // CARDS COLLECTION METHODS
  Future<void> addPokemonCardToFirestore(String username, PokemonCard pokemonCard) async {
    try {
      var userDoc = await _firestore.collection(_cardsCollection).doc(username).get();
      if (userDoc.exists) {
        await _firestore.collection(_cardsCollection).doc(username).update({
          _cardsField: FieldValue.arrayUnion([pokemonCard.toJson()]),
        });
      } else {
        await _firestore.collection(_cardsCollection).doc(username).set({
          _cardsField: [pokemonCard.toJson()],
        });
      }
    } catch (error) {
      print('Error adding Pokemon card to Firestore: $error');
    }
  }

  Future<List<PokemonCard>> getPokemonCardsByUsername(String username) async {
    try {
      var userDoc = await _firestore.collection(_cardsCollection).doc(username).get();

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

  void addFriendWithUsername(String userUsername, String friendUsername) async {
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
    final CollectionReference collection = FirebaseFirestore.instance.collection(_cardsCollection);
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
}