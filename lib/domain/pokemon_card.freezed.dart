// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PokemonCard _$PokemonCardFromJson(Map<String, dynamic> json) {
  return _PokemonCard.fromJson(json);
}

/// @nodoc
mixin _$PokemonCard {
  String get id => throw _privateConstructorUsedError; // #klm format
  String get pokemonName => throw _privateConstructorUsedError;
  String get numInBatch => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  bool get stillOwned => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PokemonCardCopyWith<PokemonCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PokemonCardCopyWith<$Res> {
  factory $PokemonCardCopyWith(
          PokemonCard value, $Res Function(PokemonCard) then) =
      _$PokemonCardCopyWithImpl<$Res, PokemonCard>;
  @useResult
  $Res call(
      {String id,
      String pokemonName,
      String numInBatch,
      String imageUrl,
      bool stillOwned});
}

/// @nodoc
class _$PokemonCardCopyWithImpl<$Res, $Val extends PokemonCard>
    implements $PokemonCardCopyWith<$Res> {
  _$PokemonCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pokemonName = null,
    Object? numInBatch = null,
    Object? imageUrl = null,
    Object? stillOwned = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pokemonName: null == pokemonName
          ? _value.pokemonName
          : pokemonName // ignore: cast_nullable_to_non_nullable
              as String,
      numInBatch: null == numInBatch
          ? _value.numInBatch
          : numInBatch // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      stillOwned: null == stillOwned
          ? _value.stillOwned
          : stillOwned // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PokemonCardImplCopyWith<$Res>
    implements $PokemonCardCopyWith<$Res> {
  factory _$$PokemonCardImplCopyWith(
          _$PokemonCardImpl value, $Res Function(_$PokemonCardImpl) then) =
      __$$PokemonCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String pokemonName,
      String numInBatch,
      String imageUrl,
      bool stillOwned});
}

/// @nodoc
class __$$PokemonCardImplCopyWithImpl<$Res>
    extends _$PokemonCardCopyWithImpl<$Res, _$PokemonCardImpl>
    implements _$$PokemonCardImplCopyWith<$Res> {
  __$$PokemonCardImplCopyWithImpl(
      _$PokemonCardImpl _value, $Res Function(_$PokemonCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pokemonName = null,
    Object? numInBatch = null,
    Object? imageUrl = null,
    Object? stillOwned = null,
  }) {
    return _then(_$PokemonCardImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pokemonName: null == pokemonName
          ? _value.pokemonName
          : pokemonName // ignore: cast_nullable_to_non_nullable
              as String,
      numInBatch: null == numInBatch
          ? _value.numInBatch
          : numInBatch // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      stillOwned: null == stillOwned
          ? _value.stillOwned
          : stillOwned // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PokemonCardImpl implements _PokemonCard {
  const _$PokemonCardImpl(
      {required this.id,
      required this.pokemonName,
      required this.numInBatch,
      required this.imageUrl,
      required this.stillOwned});

  factory _$PokemonCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$PokemonCardImplFromJson(json);

  @override
  final String id;
// #klm format
  @override
  final String pokemonName;
  @override
  final String numInBatch;
  @override
  final String imageUrl;
  @override
  final bool stillOwned;

  @override
  String toString() {
    return 'PokemonCard(id: $id, pokemonName: $pokemonName, numInBatch: $numInBatch, imageUrl: $imageUrl, stillOwned: $stillOwned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PokemonCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pokemonName, pokemonName) ||
                other.pokemonName == pokemonName) &&
            (identical(other.numInBatch, numInBatch) ||
                other.numInBatch == numInBatch) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.stillOwned, stillOwned) ||
                other.stillOwned == stillOwned));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, pokemonName, numInBatch, imageUrl, stillOwned);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PokemonCardImplCopyWith<_$PokemonCardImpl> get copyWith =>
      __$$PokemonCardImplCopyWithImpl<_$PokemonCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PokemonCardImplToJson(
      this,
    );
  }
}

abstract class _PokemonCard implements PokemonCard {
  const factory _PokemonCard(
      {required final String id,
      required final String pokemonName,
      required final String numInBatch,
      required final String imageUrl,
      required final bool stillOwned}) = _$PokemonCardImpl;

  factory _PokemonCard.fromJson(Map<String, dynamic> json) =
      _$PokemonCardImpl.fromJson;

  @override
  String get id;
  @override // #klm format
  String get pokemonName;
  @override
  String get numInBatch;
  @override
  String get imageUrl;
  @override
  bool get stillOwned;
  @override
  @JsonKey(ignore: true)
  _$$PokemonCardImplCopyWith<_$PokemonCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
