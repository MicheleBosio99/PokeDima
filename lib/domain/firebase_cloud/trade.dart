import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_dima_new/domain/pokemon_card.dart';

part 'freezed_generated/trade.freezed.dart';
part 'freezed_generated/trade.g.dart';

@freezed
class Trade with _$Trade {

  const factory Trade({
    required String tradeId,
    required String senderUsername,
    required String receiverUsername,
    required List<PokemonCard> pokemonCardsOffered,
    required List<PokemonCard> pokemonCardsRequested,
    required bool status,
  }) = _Trade;

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);
}