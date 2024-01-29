// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PokemonImpl _$$PokemonImplFromJson(Map<String, dynamic> json) =>
    _$PokemonImpl(
      name: json['name'] as String,
      id: json['id'] as String,
      imageUrl: json['imageurl'] as String,
      xDescription: json['xdescription'] as String,
      height: json['height'] as String,
      weight: json['weight'] as String,
      pokemonTypes: (json['typeofpokemon'] as List<dynamic>?)
              ?.map((e) => PokemonType.fromJson(e as String))
              .toList() ??
          const [],
      weaknesses: (json['weaknesses'] as List<dynamic>?)
              ?.map((e) => PokemonType.fromJson(e as String))
              .toList() ??
          const [],
      evolutions: (json['evolutions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      hp: json['hp'] as int,
      attack: json['attack'] as int,
      defense: json['defense'] as int,
      specialAttack: json['special_attack'] as int,
      specialDefense: json['special_defense'] as int,
      speed: json['speed'] as int,
      evolvedFrom: json['evolvedfrom'] as String,
    );

Map<String, dynamic> _$$PokemonImplToJson(_$PokemonImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'imageurl': instance.imageUrl,
      'xdescription': instance.xDescription,
      'height': instance.height,
      'weight': instance.weight,
      'typeofpokemon': instance.pokemonTypes,
      'weaknesses': instance.weaknesses,
      'evolutions': instance.evolutions,
      'hp': instance.hp,
      'attack': instance.attack,
      'defense': instance.defense,
      'special_attack': instance.specialAttack,
      'special_defense': instance.specialDefense,
      'speed': instance.speed,
      'evolvedfrom': instance.evolvedFrom,
    };
