import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';

part 'freezed_generated/cards_collection.freezed.dart';
part 'freezed_generated/cards_collection.g.dart';

@freezed
class CardsCollection with _$CardsCollection {

  const factory CardsCollection({
    required String username,
    required List<PokemonCard> pokemonCards,

  }) = _CardsCollection;

  factory CardsCollection.fromJson(Map<String, dynamic> json) => _$CardsCollectionFromJson(json);
}