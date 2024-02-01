import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';

part 'pokemon_card.freezed.dart';
part 'pokemon_card.g.dart';

@freezed
class PokemonCard with _$PokemonCard {

  const factory PokemonCard({
    required String id, // #klm format
    required String pokemonName,
    required String numInBatch,
    required String imageUrl,
    required bool stillOwned,
    required String rarity,

  }) = _PokemonCard;

  factory PokemonCard.fromJson(Map<String, dynamic> json) => _$PokemonCardFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'cardId': id,
      'pokemonName': pokemonName,
      'numInBatch': numInBatch,
      'imageUrl': imageUrl,
      'stillOwned': stillOwned,
    };
  }

  factory PokemonCard.fromFirestore(Map<String, dynamic> json, Pokemon relativePokemon) {
    return PokemonCard(
      id: json['cardId'],
      pokemonName: json['pokemonName'],
      numInBatch: json['numInBatch'],
      imageUrl: json['imageUrl'],
      stillOwned: json['stillOwned'],
      rarity: json['rarity'],
    );
  }

  factory PokemonCard.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot, Pokemon relativePokemon) {
    Map<String, dynamic> data = snapshot.data() ?? {};
    return PokemonCard(
      id: data['cardId'] ?? '',
      pokemonName: data['pokemonName'] ?? '',
      numInBatch: data['numInBatch'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      stillOwned: data['stillOwned'] ?? false,
      rarity: data['rarity'] ?? '',
    );
  }
}