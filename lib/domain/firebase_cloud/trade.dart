import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';

part 'trade.freezed.dart';
part 'trade.g.dart';

@freezed
class Trade with _$Trade {

  const factory Trade({
    required String tradeId,
    required String senderUsername,
    required String receiverUsername,
    required List<PokemonCard> pokemonCardsOffered,
    required List<PokemonCard> pokemonCardsRequested,
    required String status,
    required String timestamp,

  }) = _Trade;

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);
}