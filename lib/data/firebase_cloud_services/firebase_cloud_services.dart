import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';

class FirebaseCloudServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _cardsCollection = 'cards_collection';
  final String _usernameField = 'username';
  final String _cardsField = 'cards';

  Future<void> addPokemonCardToFirestore(String username, PokemonCard pokemonCard) async {
    try {
      var userDoc = await _firestore.collection(_cardsCollection).doc(username).get();
      if (userDoc.exists) {
        await _firestore.collection(_cardsCollection).doc(username).update({
          _cardsField: FieldValue.arrayUnion([pokemonCard.toJson()]),
        });
      } else {
        await _firestore.collection(_cardsCollection).doc(username).set({
          _usernameField: username,
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
}