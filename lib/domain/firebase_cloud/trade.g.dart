// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeImpl _$$TradeImplFromJson(Map<String, dynamic> json) => _$TradeImpl(
      tradeId: json['tradeId'] as String,
      senderUsername: json['senderUsername'] as String,
      receiverUsername: json['receiverUsername'] as String,
      pokemonCardsOffered: (json['pokemonCardsOffered'] as List<dynamic>)
          .map((e) => PokemonCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      pokemonCardsRequested: (json['pokemonCardsRequested'] as List<dynamic>)
          .map((e) => PokemonCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$$TradeImplToJson(_$TradeImpl instance) =>
    <String, dynamic>{
      'tradeId': instance.tradeId,
      'senderUsername': instance.senderUsername,
      'receiverUsername': instance.receiverUsername,
      'pokemonCardsOffered': instance.pokemonCardsOffered,
      'pokemonCardsRequested': instance.pokemonCardsRequested,
      'status': instance.status,
      'timestamp': instance.timestamp,
    };
