import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_dima_new/domain/pokemon_type.dart';

part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@freezed
class Pokemon with _$Pokemon {
  const factory Pokemon({
    required String name,
    required String id,
    @JsonKey(name: 'imageurl') required String imageUrl,
    @JsonKey(name: 'xdescription') required String xDescription,
    required String height,
    required String weight,
    // @JsonKey(name: 'typeofpokemon') required List<String> typesString,
    @Default([]) @JsonKey(name: "typeofpokemon") List<PokemonType> pokemonTypes,
    @Default([]) required List<PokemonType> weaknesses,
    required List<String> evolutions,
    required int hp,
    required int attack,
    required int defense,
    @JsonKey(name: 'special_attack') required int specialAttack,
    @JsonKey(name: 'special_defense') required int specialDefense,
    required int speed,
    @JsonKey(name: 'evolvedfrom') required String evolvedFrom,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);
}

// @freezed
// class Statistics with _$Statistics {
//   const factory Statistics({
//     required int hp,
//     required int attack,
//     required int defense,
//     @JsonKey(name: 'special_attack') required int specialAttack,
//     @JsonKey(name: 'special_defense') required int specialDefense,
//     required int speed,
//   }) = _Statistics;
//
//   factory Statistics.fromJson(Map<String, dynamic> json) => _$StatisticsFromJson(json);
// }