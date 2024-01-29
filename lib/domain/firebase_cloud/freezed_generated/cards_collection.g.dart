// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../cards_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardsCollectionImpl _$$CardsCollectionImplFromJson(
        Map<String, dynamic> json) =>
    _$CardsCollectionImpl(
      username: json['username'] as String,
      pokemonCards: (json['pokemonCards'] as List<dynamic>)
          .map((e) => PokemonCard.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CardsCollectionImplToJson(
        _$CardsCollectionImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'pokemonCards': instance.pokemonCards,
    };
