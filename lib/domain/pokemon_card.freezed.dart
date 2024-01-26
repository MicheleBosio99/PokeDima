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
  String get pokemonName => throw _privateConstructorUsedError;
  String get numInBatch => throw _privateConstructorUsedError;
  @Uint8ListConverter()
  Uint8List get imageBytes => throw _privateConstructorUsedError;
  Pokemon get relativePokemon => throw _privateConstructorUsedError;

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
      {String pokemonName,
      String numInBatch,
      @Uint8ListConverter() Uint8List imageBytes,
      Pokemon relativePokemon});

  $PokemonCopyWith<$Res> get relativePokemon;
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
    Object? pokemonName = null,
    Object? numInBatch = null,
    Object? imageBytes = null,
    Object? relativePokemon = null,
  }) {
    return _then(_value.copyWith(
      pokemonName: null == pokemonName
          ? _value.pokemonName
          : pokemonName // ignore: cast_nullable_to_non_nullable
              as String,
      numInBatch: null == numInBatch
          ? _value.numInBatch
          : numInBatch // ignore: cast_nullable_to_non_nullable
              as String,
      imageBytes: null == imageBytes
          ? _value.imageBytes
          : imageBytes // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      relativePokemon: null == relativePokemon
          ? _value.relativePokemon
          : relativePokemon // ignore: cast_nullable_to_non_nullable
              as Pokemon,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PokemonCopyWith<$Res> get relativePokemon {
    return $PokemonCopyWith<$Res>(_value.relativePokemon, (value) {
      return _then(_value.copyWith(relativePokemon: value) as $Val);
    });
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
      {String pokemonName,
      String numInBatch,
      @Uint8ListConverter() Uint8List imageBytes,
      Pokemon relativePokemon});

  @override
  $PokemonCopyWith<$Res> get relativePokemon;
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
    Object? pokemonName = null,
    Object? numInBatch = null,
    Object? imageBytes = null,
    Object? relativePokemon = null,
  }) {
    return _then(_$PokemonCardImpl(
      pokemonName: null == pokemonName
          ? _value.pokemonName
          : pokemonName // ignore: cast_nullable_to_non_nullable
              as String,
      numInBatch: null == numInBatch
          ? _value.numInBatch
          : numInBatch // ignore: cast_nullable_to_non_nullable
              as String,
      imageBytes: null == imageBytes
          ? _value.imageBytes
          : imageBytes // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      relativePokemon: null == relativePokemon
          ? _value.relativePokemon
          : relativePokemon // ignore: cast_nullable_to_non_nullable
              as Pokemon,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PokemonCardImpl implements _PokemonCard {
  const _$PokemonCardImpl(
      {required this.pokemonName,
      required this.numInBatch,
      @Uint8ListConverter() required this.imageBytes,
      required this.relativePokemon});

  factory _$PokemonCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$PokemonCardImplFromJson(json);

  @override
  final String pokemonName;
  @override
  final String numInBatch;
  @override
  @Uint8ListConverter()
  final Uint8List imageBytes;
  @override
  final Pokemon relativePokemon;

  @override
  String toString() {
    return 'PokemonCard(pokemonName: $pokemonName, numInBatch: $numInBatch, imageBytes: $imageBytes, relativePokemon: $relativePokemon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PokemonCardImpl &&
            (identical(other.pokemonName, pokemonName) ||
                other.pokemonName == pokemonName) &&
            (identical(other.numInBatch, numInBatch) ||
                other.numInBatch == numInBatch) &&
            const DeepCollectionEquality()
                .equals(other.imageBytes, imageBytes) &&
            (identical(other.relativePokemon, relativePokemon) ||
                other.relativePokemon == relativePokemon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pokemonName, numInBatch,
      const DeepCollectionEquality().hash(imageBytes), relativePokemon);

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
      {required final String pokemonName,
      required final String numInBatch,
      @Uint8ListConverter() required final Uint8List imageBytes,
      required final Pokemon relativePokemon}) = _$PokemonCardImpl;

  factory _PokemonCard.fromJson(Map<String, dynamic> json) =
      _$PokemonCardImpl.fromJson;

  @override
  String get pokemonName;
  @override
  String get numInBatch;
  @override
  @Uint8ListConverter()
  Uint8List get imageBytes;
  @override
  Pokemon get relativePokemon;
  @override
  @JsonKey(ignore: true)
  _$$PokemonCardImplCopyWith<_$PokemonCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
