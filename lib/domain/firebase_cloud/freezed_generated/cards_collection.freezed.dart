// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../cards_collection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CardsCollection _$CardsCollectionFromJson(Map<String, dynamic> json) {
  return _CardsCollection.fromJson(json);
}

/// @nodoc
mixin _$CardsCollection {
  String get username => throw _privateConstructorUsedError;
  List<PokemonCard> get pokemonCards => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CardsCollectionCopyWith<CardsCollection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardsCollectionCopyWith<$Res> {
  factory $CardsCollectionCopyWith(
          CardsCollection value, $Res Function(CardsCollection) then) =
      _$CardsCollectionCopyWithImpl<$Res, CardsCollection>;
  @useResult
  $Res call({String username, List<PokemonCard> pokemonCards});
}

/// @nodoc
class _$CardsCollectionCopyWithImpl<$Res, $Val extends CardsCollection>
    implements $CardsCollectionCopyWith<$Res> {
  _$CardsCollectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? pokemonCards = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      pokemonCards: null == pokemonCards
          ? _value.pokemonCards
          : pokemonCards // ignore: cast_nullable_to_non_nullable
              as List<PokemonCard>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CardsCollectionImplCopyWith<$Res>
    implements $CardsCollectionCopyWith<$Res> {
  factory _$$CardsCollectionImplCopyWith(_$CardsCollectionImpl value,
          $Res Function(_$CardsCollectionImpl) then) =
      __$$CardsCollectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username, List<PokemonCard> pokemonCards});
}

/// @nodoc
class __$$CardsCollectionImplCopyWithImpl<$Res>
    extends _$CardsCollectionCopyWithImpl<$Res, _$CardsCollectionImpl>
    implements _$$CardsCollectionImplCopyWith<$Res> {
  __$$CardsCollectionImplCopyWithImpl(
      _$CardsCollectionImpl _value, $Res Function(_$CardsCollectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? pokemonCards = null,
  }) {
    return _then(_$CardsCollectionImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      pokemonCards: null == pokemonCards
          ? _value._pokemonCards
          : pokemonCards // ignore: cast_nullable_to_non_nullable
              as List<PokemonCard>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CardsCollectionImpl implements _CardsCollection {
  const _$CardsCollectionImpl(
      {required this.username, required final List<PokemonCard> pokemonCards})
      : _pokemonCards = pokemonCards;

  factory _$CardsCollectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CardsCollectionImplFromJson(json);

  @override
  final String username;
  final List<PokemonCard> _pokemonCards;
  @override
  List<PokemonCard> get pokemonCards {
    if (_pokemonCards is EqualUnmodifiableListView) return _pokemonCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pokemonCards);
  }

  @override
  String toString() {
    return 'CardsCollection(username: $username, pokemonCards: $pokemonCards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardsCollectionImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            const DeepCollectionEquality()
                .equals(other._pokemonCards, _pokemonCards));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, username,
      const DeepCollectionEquality().hash(_pokemonCards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CardsCollectionImplCopyWith<_$CardsCollectionImpl> get copyWith =>
      __$$CardsCollectionImplCopyWithImpl<_$CardsCollectionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CardsCollectionImplToJson(
      this,
    );
  }
}

abstract class _CardsCollection implements CardsCollection {
  const factory _CardsCollection(
      {required final String username,
      required final List<PokemonCard> pokemonCards}) = _$CardsCollectionImpl;

  factory _CardsCollection.fromJson(Map<String, dynamic> json) =
      _$CardsCollectionImpl.fromJson;

  @override
  String get username;
  @override
  List<PokemonCard> get pokemonCards;
  @override
  @JsonKey(ignore: true)
  _$$CardsCollectionImplCopyWith<_$CardsCollectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
