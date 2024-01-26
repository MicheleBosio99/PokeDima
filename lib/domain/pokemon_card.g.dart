// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PokemonCardImpl _$$PokemonCardImplFromJson(Map<String, dynamic> json) =>
    _$PokemonCardImpl(
      pokemonName: json['pokemonName'] as String,
      numInBatch: json['numInBatch'] as String,
      imageBytes:
          const Uint8ListConverter().fromJson(json['imageBytes'] as List<int>),
      relativePokemon:
          Pokemon.fromJson(json['relativePokemon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PokemonCardImplToJson(_$PokemonCardImpl instance) =>
    <String, dynamic>{
      'pokemonName': instance.pokemonName,
      'numInBatch': instance.numInBatch,
      'imageBytes': const Uint8ListConverter().toJson(instance.imageBytes),
      'relativePokemon': instance.relativePokemon,
    };
