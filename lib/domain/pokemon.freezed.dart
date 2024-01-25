// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Pokemon _$PokemonFromJson(Map<String, dynamic> json) {
  return _Pokemon.fromJson(json);
}

/// @nodoc
mixin _$Pokemon {
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageurl')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'xdescription')
  String get xDescription => throw _privateConstructorUsedError;
  String get height => throw _privateConstructorUsedError;
  String get weight =>
      throw _privateConstructorUsedError; // @JsonKey(name: 'typeofpokemon') required List<String> typesString,
  @JsonKey(name: "typeofpokemon")
  List<PokemonType> get pokemonTypes => throw _privateConstructorUsedError;
  List<PokemonType> get weaknesses => throw _privateConstructorUsedError;
  List<String> get evolutions => throw _privateConstructorUsedError;
  int get hp => throw _privateConstructorUsedError;
  int get attack => throw _privateConstructorUsedError;
  int get defense => throw _privateConstructorUsedError;
  @JsonKey(name: 'special_attack')
  int get specialAttack => throw _privateConstructorUsedError;
  @JsonKey(name: 'special_defense')
  int get specialDefense => throw _privateConstructorUsedError;
  int get speed => throw _privateConstructorUsedError;
  @JsonKey(name: 'evolvedfrom')
  String get evolvedFrom => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PokemonCopyWith<Pokemon> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PokemonCopyWith<$Res> {
  factory $PokemonCopyWith(Pokemon value, $Res Function(Pokemon) then) =
      _$PokemonCopyWithImpl<$Res, Pokemon>;
  @useResult
  $Res call(
      {String name,
      String id,
      @JsonKey(name: 'imageurl') String imageUrl,
      @JsonKey(name: 'xdescription') String xDescription,
      String height,
      String weight,
      @JsonKey(name: "typeofpokemon") List<PokemonType> pokemonTypes,
      List<PokemonType> weaknesses,
      List<String> evolutions,
      int hp,
      int attack,
      int defense,
      @JsonKey(name: 'special_attack') int specialAttack,
      @JsonKey(name: 'special_defense') int specialDefense,
      int speed,
      @JsonKey(name: 'evolvedfrom') String evolvedFrom});
}

/// @nodoc
class _$PokemonCopyWithImpl<$Res, $Val extends Pokemon>
    implements $PokemonCopyWith<$Res> {
  _$PokemonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? imageUrl = null,
    Object? xDescription = null,
    Object? height = null,
    Object? weight = null,
    Object? pokemonTypes = null,
    Object? weaknesses = null,
    Object? evolutions = null,
    Object? hp = null,
    Object? attack = null,
    Object? defense = null,
    Object? specialAttack = null,
    Object? specialDefense = null,
    Object? speed = null,
    Object? evolvedFrom = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      xDescription: null == xDescription
          ? _value.xDescription
          : xDescription // ignore: cast_nullable_to_non_nullable
              as String,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as String,
      pokemonTypes: null == pokemonTypes
          ? _value.pokemonTypes
          : pokemonTypes // ignore: cast_nullable_to_non_nullable
              as List<PokemonType>,
      weaknesses: null == weaknesses
          ? _value.weaknesses
          : weaknesses // ignore: cast_nullable_to_non_nullable
              as List<PokemonType>,
      evolutions: null == evolutions
          ? _value.evolutions
          : evolutions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hp: null == hp
          ? _value.hp
          : hp // ignore: cast_nullable_to_non_nullable
              as int,
      attack: null == attack
          ? _value.attack
          : attack // ignore: cast_nullable_to_non_nullable
              as int,
      defense: null == defense
          ? _value.defense
          : defense // ignore: cast_nullable_to_non_nullable
              as int,
      specialAttack: null == specialAttack
          ? _value.specialAttack
          : specialAttack // ignore: cast_nullable_to_non_nullable
              as int,
      specialDefense: null == specialDefense
          ? _value.specialDefense
          : specialDefense // ignore: cast_nullable_to_non_nullable
              as int,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as int,
      evolvedFrom: null == evolvedFrom
          ? _value.evolvedFrom
          : evolvedFrom // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PokemonImplCopyWith<$Res> implements $PokemonCopyWith<$Res> {
  factory _$$PokemonImplCopyWith(
          _$PokemonImpl value, $Res Function(_$PokemonImpl) then) =
      __$$PokemonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String id,
      @JsonKey(name: 'imageurl') String imageUrl,
      @JsonKey(name: 'xdescription') String xDescription,
      String height,
      String weight,
      @JsonKey(name: "typeofpokemon") List<PokemonType> pokemonTypes,
      List<PokemonType> weaknesses,
      List<String> evolutions,
      int hp,
      int attack,
      int defense,
      @JsonKey(name: 'special_attack') int specialAttack,
      @JsonKey(name: 'special_defense') int specialDefense,
      int speed,
      @JsonKey(name: 'evolvedfrom') String evolvedFrom});
}

/// @nodoc
class __$$PokemonImplCopyWithImpl<$Res>
    extends _$PokemonCopyWithImpl<$Res, _$PokemonImpl>
    implements _$$PokemonImplCopyWith<$Res> {
  __$$PokemonImplCopyWithImpl(
      _$PokemonImpl _value, $Res Function(_$PokemonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? imageUrl = null,
    Object? xDescription = null,
    Object? height = null,
    Object? weight = null,
    Object? pokemonTypes = null,
    Object? weaknesses = null,
    Object? evolutions = null,
    Object? hp = null,
    Object? attack = null,
    Object? defense = null,
    Object? specialAttack = null,
    Object? specialDefense = null,
    Object? speed = null,
    Object? evolvedFrom = null,
  }) {
    return _then(_$PokemonImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      xDescription: null == xDescription
          ? _value.xDescription
          : xDescription // ignore: cast_nullable_to_non_nullable
              as String,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as String,
      pokemonTypes: null == pokemonTypes
          ? _value._pokemonTypes
          : pokemonTypes // ignore: cast_nullable_to_non_nullable
              as List<PokemonType>,
      weaknesses: null == weaknesses
          ? _value._weaknesses
          : weaknesses // ignore: cast_nullable_to_non_nullable
              as List<PokemonType>,
      evolutions: null == evolutions
          ? _value._evolutions
          : evolutions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hp: null == hp
          ? _value.hp
          : hp // ignore: cast_nullable_to_non_nullable
              as int,
      attack: null == attack
          ? _value.attack
          : attack // ignore: cast_nullable_to_non_nullable
              as int,
      defense: null == defense
          ? _value.defense
          : defense // ignore: cast_nullable_to_non_nullable
              as int,
      specialAttack: null == specialAttack
          ? _value.specialAttack
          : specialAttack // ignore: cast_nullable_to_non_nullable
              as int,
      specialDefense: null == specialDefense
          ? _value.specialDefense
          : specialDefense // ignore: cast_nullable_to_non_nullable
              as int,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as int,
      evolvedFrom: null == evolvedFrom
          ? _value.evolvedFrom
          : evolvedFrom // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PokemonImpl implements _Pokemon {
  const _$PokemonImpl(
      {required this.name,
      required this.id,
      @JsonKey(name: 'imageurl') required this.imageUrl,
      @JsonKey(name: 'xdescription') required this.xDescription,
      required this.height,
      required this.weight,
      @JsonKey(name: "typeofpokemon")
      final List<PokemonType> pokemonTypes = const [],
      final List<PokemonType> weaknesses = const [],
      required final List<String> evolutions,
      required this.hp,
      required this.attack,
      required this.defense,
      @JsonKey(name: 'special_attack') required this.specialAttack,
      @JsonKey(name: 'special_defense') required this.specialDefense,
      required this.speed,
      @JsonKey(name: 'evolvedfrom') required this.evolvedFrom})
      : _pokemonTypes = pokemonTypes,
        _weaknesses = weaknesses,
        _evolutions = evolutions;

  factory _$PokemonImpl.fromJson(Map<String, dynamic> json) =>
      _$$PokemonImplFromJson(json);

  @override
  final String name;
  @override
  final String id;
  @override
  @JsonKey(name: 'imageurl')
  final String imageUrl;
  @override
  @JsonKey(name: 'xdescription')
  final String xDescription;
  @override
  final String height;
  @override
  final String weight;
// @JsonKey(name: 'typeofpokemon') required List<String> typesString,
  final List<PokemonType> _pokemonTypes;
// @JsonKey(name: 'typeofpokemon') required List<String> typesString,
  @override
  @JsonKey(name: "typeofpokemon")
  List<PokemonType> get pokemonTypes {
    if (_pokemonTypes is EqualUnmodifiableListView) return _pokemonTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pokemonTypes);
  }

  final List<PokemonType> _weaknesses;
  @override
  @JsonKey()
  List<PokemonType> get weaknesses {
    if (_weaknesses is EqualUnmodifiableListView) return _weaknesses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weaknesses);
  }

  final List<String> _evolutions;
  @override
  List<String> get evolutions {
    if (_evolutions is EqualUnmodifiableListView) return _evolutions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_evolutions);
  }

  @override
  final int hp;
  @override
  final int attack;
  @override
  final int defense;
  @override
  @JsonKey(name: 'special_attack')
  final int specialAttack;
  @override
  @JsonKey(name: 'special_defense')
  final int specialDefense;
  @override
  final int speed;
  @override
  @JsonKey(name: 'evolvedfrom')
  final String evolvedFrom;

  @override
  String toString() {
    return 'Pokemon(name: $name, id: $id, imageUrl: $imageUrl, xDescription: $xDescription, height: $height, weight: $weight, pokemonTypes: $pokemonTypes, weaknesses: $weaknesses, evolutions: $evolutions, hp: $hp, attack: $attack, defense: $defense, specialAttack: $specialAttack, specialDefense: $specialDefense, speed: $speed, evolvedFrom: $evolvedFrom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PokemonImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.xDescription, xDescription) ||
                other.xDescription == xDescription) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            const DeepCollectionEquality()
                .equals(other._pokemonTypes, _pokemonTypes) &&
            const DeepCollectionEquality()
                .equals(other._weaknesses, _weaknesses) &&
            const DeepCollectionEquality()
                .equals(other._evolutions, _evolutions) &&
            (identical(other.hp, hp) || other.hp == hp) &&
            (identical(other.attack, attack) || other.attack == attack) &&
            (identical(other.defense, defense) || other.defense == defense) &&
            (identical(other.specialAttack, specialAttack) ||
                other.specialAttack == specialAttack) &&
            (identical(other.specialDefense, specialDefense) ||
                other.specialDefense == specialDefense) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.evolvedFrom, evolvedFrom) ||
                other.evolvedFrom == evolvedFrom));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      id,
      imageUrl,
      xDescription,
      height,
      weight,
      const DeepCollectionEquality().hash(_pokemonTypes),
      const DeepCollectionEquality().hash(_weaknesses),
      const DeepCollectionEquality().hash(_evolutions),
      hp,
      attack,
      defense,
      specialAttack,
      specialDefense,
      speed,
      evolvedFrom);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PokemonImplCopyWith<_$PokemonImpl> get copyWith =>
      __$$PokemonImplCopyWithImpl<_$PokemonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PokemonImplToJson(
      this,
    );
  }
}

abstract class _Pokemon implements Pokemon {
  const factory _Pokemon(
          {required final String name,
          required final String id,
          @JsonKey(name: 'imageurl') required final String imageUrl,
          @JsonKey(name: 'xdescription') required final String xDescription,
          required final String height,
          required final String weight,
          @JsonKey(name: "typeofpokemon") final List<PokemonType> pokemonTypes,
          required final List<PokemonType> weaknesses,
          required final List<String> evolutions,
          required final int hp,
          required final int attack,
          required final int defense,
          @JsonKey(name: 'special_attack') required final int specialAttack,
          @JsonKey(name: 'special_defense') required final int specialDefense,
          required final int speed,
          @JsonKey(name: 'evolvedfrom') required final String evolvedFrom}) =
      _$PokemonImpl;

  factory _Pokemon.fromJson(Map<String, dynamic> json) = _$PokemonImpl.fromJson;

  @override
  String get name;
  @override
  String get id;
  @override
  @JsonKey(name: 'imageurl')
  String get imageUrl;
  @override
  @JsonKey(name: 'xdescription')
  String get xDescription;
  @override
  String get height;
  @override
  String get weight;
  @override // @JsonKey(name: 'typeofpokemon') required List<String> typesString,
  @JsonKey(name: "typeofpokemon")
  List<PokemonType> get pokemonTypes;
  @override
  List<PokemonType> get weaknesses;
  @override
  List<String> get evolutions;
  @override
  int get hp;
  @override
  int get attack;
  @override
  int get defense;
  @override
  @JsonKey(name: 'special_attack')
  int get specialAttack;
  @override
  @JsonKey(name: 'special_defense')
  int get specialDefense;
  @override
  int get speed;
  @override
  @JsonKey(name: 'evolvedfrom')
  String get evolvedFrom;
  @override
  @JsonKey(ignore: true)
  _$$PokemonImplCopyWith<_$PokemonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
