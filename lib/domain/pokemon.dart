import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@freezed
class Pokemon with _$Pokemon {
  const factory Pokemon({
    required String name,
    required PokemonID id,
    required String imageUrl,
    required String xDescription,
    required String height,
    required String weight,
    required List<Type> types,
    required List<Type> weaknesses,
    required List<String> evolutions,
    required Statistics statistics,
    required String evolvedFrom,
  }) = _Pokemon;
}

@freezed
class Type with _$Type {
  const factory Type({
    required String name,
    required Color color,
  }) = _Type;
}

@freezed
class Statistics with _$Statistics {
  const factory Statistics({
    required int hp,
    required int attack,
    required int defense,
    required int specialAttack,
    required int specialDefense,
    required int speed,
  }) = _Statistics;
}

@freezed
class PokemonID with _$PokemonID {
  const factory PokemonID({
    required String id,
  }) = _PokemonID;
}