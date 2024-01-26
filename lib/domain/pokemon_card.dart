import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_dima_new/domain/pokemon.dart';

part 'pokemon_card.freezed.dart';
part 'pokemon_card.g.dart';

@freezed
class PokemonCard with _$PokemonCard {

  const factory PokemonCard({
    required String pokemonName,
    required String numInBatch,
    @Uint8ListConverter()  required Uint8List imageBytes,
    required Pokemon relativePokemon,

  }) = _PokemonCard;

  factory PokemonCard.fromJson(Map<String, dynamic> json) => _$PokemonCardFromJson(json);

}

class Uint8ListConverter implements JsonConverter<Uint8List, List<int>> {
  const Uint8ListConverter();

  @override
  Uint8List fromJson(List<int> json) {
    return Uint8List.fromList(json);
  }

  @override
  List<int> toJson(Uint8List object) {
    return object.toList();
  }
}