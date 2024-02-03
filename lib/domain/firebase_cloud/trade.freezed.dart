// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Trade _$TradeFromJson(Map<String, dynamic> json) {
  return _Trade.fromJson(json);
}

/// @nodoc
mixin _$Trade {
  String get tradeId => throw _privateConstructorUsedError;
  String get senderUsername => throw _privateConstructorUsedError;
  String get receiverUsername => throw _privateConstructorUsedError;
  List<PokemonCard> get pokemonCardsOffered =>
      throw _privateConstructorUsedError;
  List<PokemonCard> get pokemonCardsRequested =>
      throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TradeCopyWith<Trade> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeCopyWith<$Res> {
  factory $TradeCopyWith(Trade value, $Res Function(Trade) then) =
      _$TradeCopyWithImpl<$Res, Trade>;
  @useResult
  $Res call(
      {String tradeId,
      String senderUsername,
      String receiverUsername,
      List<PokemonCard> pokemonCardsOffered,
      List<PokemonCard> pokemonCardsRequested,
      String status,
      String timestamp});
}

/// @nodoc
class _$TradeCopyWithImpl<$Res, $Val extends Trade>
    implements $TradeCopyWith<$Res> {
  _$TradeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeId = null,
    Object? senderUsername = null,
    Object? receiverUsername = null,
    Object? pokemonCardsOffered = null,
    Object? pokemonCardsRequested = null,
    Object? status = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      tradeId: null == tradeId
          ? _value.tradeId
          : tradeId // ignore: cast_nullable_to_non_nullable
              as String,
      senderUsername: null == senderUsername
          ? _value.senderUsername
          : senderUsername // ignore: cast_nullable_to_non_nullable
              as String,
      receiverUsername: null == receiverUsername
          ? _value.receiverUsername
          : receiverUsername // ignore: cast_nullable_to_non_nullable
              as String,
      pokemonCardsOffered: null == pokemonCardsOffered
          ? _value.pokemonCardsOffered
          : pokemonCardsOffered // ignore: cast_nullable_to_non_nullable
              as List<PokemonCard>,
      pokemonCardsRequested: null == pokemonCardsRequested
          ? _value.pokemonCardsRequested
          : pokemonCardsRequested // ignore: cast_nullable_to_non_nullable
              as List<PokemonCard>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeImplCopyWith<$Res> implements $TradeCopyWith<$Res> {
  factory _$$TradeImplCopyWith(
          _$TradeImpl value, $Res Function(_$TradeImpl) then) =
      __$$TradeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String tradeId,
      String senderUsername,
      String receiverUsername,
      List<PokemonCard> pokemonCardsOffered,
      List<PokemonCard> pokemonCardsRequested,
      String status,
      String timestamp});
}

/// @nodoc
class __$$TradeImplCopyWithImpl<$Res>
    extends _$TradeCopyWithImpl<$Res, _$TradeImpl>
    implements _$$TradeImplCopyWith<$Res> {
  __$$TradeImplCopyWithImpl(
      _$TradeImpl _value, $Res Function(_$TradeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tradeId = null,
    Object? senderUsername = null,
    Object? receiverUsername = null,
    Object? pokemonCardsOffered = null,
    Object? pokemonCardsRequested = null,
    Object? status = null,
    Object? timestamp = null,
  }) {
    return _then(_$TradeImpl(
      tradeId: null == tradeId
          ? _value.tradeId
          : tradeId // ignore: cast_nullable_to_non_nullable
              as String,
      senderUsername: null == senderUsername
          ? _value.senderUsername
          : senderUsername // ignore: cast_nullable_to_non_nullable
              as String,
      receiverUsername: null == receiverUsername
          ? _value.receiverUsername
          : receiverUsername // ignore: cast_nullable_to_non_nullable
              as String,
      pokemonCardsOffered: null == pokemonCardsOffered
          ? _value._pokemonCardsOffered
          : pokemonCardsOffered // ignore: cast_nullable_to_non_nullable
              as List<PokemonCard>,
      pokemonCardsRequested: null == pokemonCardsRequested
          ? _value._pokemonCardsRequested
          : pokemonCardsRequested // ignore: cast_nullable_to_non_nullable
              as List<PokemonCard>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeImpl implements _Trade {
  const _$TradeImpl(
      {required this.tradeId,
      required this.senderUsername,
      required this.receiverUsername,
      required final List<PokemonCard> pokemonCardsOffered,
      required final List<PokemonCard> pokemonCardsRequested,
      required this.status,
      required this.timestamp})
      : _pokemonCardsOffered = pokemonCardsOffered,
        _pokemonCardsRequested = pokemonCardsRequested;

  factory _$TradeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeImplFromJson(json);

  @override
  final String tradeId;
  @override
  final String senderUsername;
  @override
  final String receiverUsername;
  final List<PokemonCard> _pokemonCardsOffered;
  @override
  List<PokemonCard> get pokemonCardsOffered {
    if (_pokemonCardsOffered is EqualUnmodifiableListView)
      return _pokemonCardsOffered;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pokemonCardsOffered);
  }

  final List<PokemonCard> _pokemonCardsRequested;
  @override
  List<PokemonCard> get pokemonCardsRequested {
    if (_pokemonCardsRequested is EqualUnmodifiableListView)
      return _pokemonCardsRequested;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pokemonCardsRequested);
  }

  @override
  final String status;
  @override
  final String timestamp;

  @override
  String toString() {
    return 'Trade(tradeId: $tradeId, senderUsername: $senderUsername, receiverUsername: $receiverUsername, pokemonCardsOffered: $pokemonCardsOffered, pokemonCardsRequested: $pokemonCardsRequested, status: $status, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeImpl &&
            (identical(other.tradeId, tradeId) || other.tradeId == tradeId) &&
            (identical(other.senderUsername, senderUsername) ||
                other.senderUsername == senderUsername) &&
            (identical(other.receiverUsername, receiverUsername) ||
                other.receiverUsername == receiverUsername) &&
            const DeepCollectionEquality()
                .equals(other._pokemonCardsOffered, _pokemonCardsOffered) &&
            const DeepCollectionEquality()
                .equals(other._pokemonCardsRequested, _pokemonCardsRequested) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      tradeId,
      senderUsername,
      receiverUsername,
      const DeepCollectionEquality().hash(_pokemonCardsOffered),
      const DeepCollectionEquality().hash(_pokemonCardsRequested),
      status,
      timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeImplCopyWith<_$TradeImpl> get copyWith =>
      __$$TradeImplCopyWithImpl<_$TradeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeImplToJson(
      this,
    );
  }
}

abstract class _Trade implements Trade {
  const factory _Trade(
      {required final String tradeId,
      required final String senderUsername,
      required final String receiverUsername,
      required final List<PokemonCard> pokemonCardsOffered,
      required final List<PokemonCard> pokemonCardsRequested,
      required final String status,
      required final String timestamp}) = _$TradeImpl;

  factory _Trade.fromJson(Map<String, dynamic> json) = _$TradeImpl.fromJson;

  @override
  String get tradeId;
  @override
  String get senderUsername;
  @override
  String get receiverUsername;
  @override
  List<PokemonCard> get pokemonCardsOffered;
  @override
  List<PokemonCard> get pokemonCardsRequested;
  @override
  String get status;
  @override
  String get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$TradeImplCopyWith<_$TradeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
