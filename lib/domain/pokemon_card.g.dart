// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PokemonCardImpl _$$PokemonCardImplFromJson(Map<String, dynamic> json) =>
    _$PokemonCardImpl(
      id: json['id'] as String,
      pokemonName: json['pokemonName'] as String,
      numInBatch: json['numInBatch'] as String,
      imageUrl: json['imageUrl'] as String,
      stillOwned: json['stillOwned'] as bool,
      rarity: json['rarity'] as String,
    );

Map<String, dynamic> _$$PokemonCardImplToJson(_$PokemonCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pokemonName': instance.pokemonName,
      'numInBatch': instance.numInBatch,
      'imageUrl': instance.imageUrl,
      'stillOwned': instance.stillOwned,
      'rarity': instance.rarity,
    };
