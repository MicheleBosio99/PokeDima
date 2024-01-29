// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get realName => throw _privateConstructorUsedError;
  String get profilePictureUrl => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;
  List<String> get friendsUsernames => throw _privateConstructorUsedError;
  String get accountCreationDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String username,
      String email,
      String realName,
      String profilePictureUrl,
      String bio,
      List<String> friendsUsernames,
      String accountCreationDate});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? realName = null,
    Object? profilePictureUrl = null,
    Object? bio = null,
    Object? friendsUsernames = null,
    Object? accountCreationDate = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      realName: null == realName
          ? _value.realName
          : realName // ignore: cast_nullable_to_non_nullable
              as String,
      profilePictureUrl: null == profilePictureUrl
          ? _value.profilePictureUrl
          : profilePictureUrl // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      friendsUsernames: null == friendsUsernames
          ? _value.friendsUsernames
          : friendsUsernames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      accountCreationDate: null == accountCreationDate
          ? _value.accountCreationDate
          : accountCreationDate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username,
      String email,
      String realName,
      String profilePictureUrl,
      String bio,
      List<String> friendsUsernames,
      String accountCreationDate});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? realName = null,
    Object? profilePictureUrl = null,
    Object? bio = null,
    Object? friendsUsernames = null,
    Object? accountCreationDate = null,
  }) {
    return _then(_$UserImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      realName: null == realName
          ? _value.realName
          : realName // ignore: cast_nullable_to_non_nullable
              as String,
      profilePictureUrl: null == profilePictureUrl
          ? _value.profilePictureUrl
          : profilePictureUrl // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      friendsUsernames: null == friendsUsernames
          ? _value._friendsUsernames
          : friendsUsernames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      accountCreationDate: null == accountCreationDate
          ? _value.accountCreationDate
          : accountCreationDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.username,
      required this.email,
      required this.realName,
      required this.profilePictureUrl,
      required this.bio,
      required final List<String> friendsUsernames,
      required this.accountCreationDate})
      : _friendsUsernames = friendsUsernames;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String username;
  @override
  final String email;
  @override
  final String realName;
  @override
  final String profilePictureUrl;
  @override
  final String bio;
  final List<String> _friendsUsernames;
  @override
  List<String> get friendsUsernames {
    if (_friendsUsernames is EqualUnmodifiableListView)
      return _friendsUsernames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_friendsUsernames);
  }

  @override
  final String accountCreationDate;

  @override
  String toString() {
    return 'User(username: $username, email: $email, realName: $realName, profilePictureUrl: $profilePictureUrl, bio: $bio, friendsUsernames: $friendsUsernames, accountCreationDate: $accountCreationDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.realName, realName) ||
                other.realName == realName) &&
            (identical(other.profilePictureUrl, profilePictureUrl) ||
                other.profilePictureUrl == profilePictureUrl) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            const DeepCollectionEquality()
                .equals(other._friendsUsernames, _friendsUsernames) &&
            (identical(other.accountCreationDate, accountCreationDate) ||
                other.accountCreationDate == accountCreationDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      username,
      email,
      realName,
      profilePictureUrl,
      bio,
      const DeepCollectionEquality().hash(_friendsUsernames),
      accountCreationDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final String username,
      required final String email,
      required final String realName,
      required final String profilePictureUrl,
      required final String bio,
      required final List<String> friendsUsernames,
      required final String accountCreationDate}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get username;
  @override
  String get email;
  @override
  String get realName;
  @override
  String get profilePictureUrl;
  @override
  String get bio;
  @override
  List<String> get friendsUsernames;
  @override
  String get accountCreationDate;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
