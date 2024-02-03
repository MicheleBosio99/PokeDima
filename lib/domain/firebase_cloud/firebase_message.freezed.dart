// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firebase_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirebaseMessage _$FirebaseMessageFromJson(Map<String, dynamic> json) {
  return _FirebaseMessage.fromJson(json);
}

/// @nodoc
mixin _$FirebaseMessage {
  String get senderId => throw _privateConstructorUsedError;
  String get senderEmail => throw _privateConstructorUsedError;
  String get receiverId => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirebaseMessageCopyWith<FirebaseMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirebaseMessageCopyWith<$Res> {
  factory $FirebaseMessageCopyWith(
          FirebaseMessage value, $Res Function(FirebaseMessage) then) =
      _$FirebaseMessageCopyWithImpl<$Res, FirebaseMessage>;
  @useResult
  $Res call(
      {String senderId,
      String senderEmail,
      String receiverId,
      String message,
      String timestamp});
}

/// @nodoc
class _$FirebaseMessageCopyWithImpl<$Res, $Val extends FirebaseMessage>
    implements $FirebaseMessageCopyWith<$Res> {
  _$FirebaseMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderId = null,
    Object? senderEmail = null,
    Object? receiverId = null,
    Object? message = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderEmail: null == senderEmail
          ? _value.senderEmail
          : senderEmail // ignore: cast_nullable_to_non_nullable
              as String,
      receiverId: null == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FirebaseMessageImplCopyWith<$Res>
    implements $FirebaseMessageCopyWith<$Res> {
  factory _$$FirebaseMessageImplCopyWith(_$FirebaseMessageImpl value,
          $Res Function(_$FirebaseMessageImpl) then) =
      __$$FirebaseMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String senderId,
      String senderEmail,
      String receiverId,
      String message,
      String timestamp});
}

/// @nodoc
class __$$FirebaseMessageImplCopyWithImpl<$Res>
    extends _$FirebaseMessageCopyWithImpl<$Res, _$FirebaseMessageImpl>
    implements _$$FirebaseMessageImplCopyWith<$Res> {
  __$$FirebaseMessageImplCopyWithImpl(
      _$FirebaseMessageImpl _value, $Res Function(_$FirebaseMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderId = null,
    Object? senderEmail = null,
    Object? receiverId = null,
    Object? message = null,
    Object? timestamp = null,
  }) {
    return _then(_$FirebaseMessageImpl(
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderEmail: null == senderEmail
          ? _value.senderEmail
          : senderEmail // ignore: cast_nullable_to_non_nullable
              as String,
      receiverId: null == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
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
class _$FirebaseMessageImpl implements _FirebaseMessage {
  const _$FirebaseMessageImpl(
      {required this.senderId,
      required this.senderEmail,
      required this.receiverId,
      required this.message,
      required this.timestamp});

  factory _$FirebaseMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirebaseMessageImplFromJson(json);

  @override
  final String senderId;
  @override
  final String senderEmail;
  @override
  final String receiverId;
  @override
  final String message;
  @override
  final String timestamp;

  @override
  String toString() {
    return 'FirebaseMessage(senderId: $senderId, senderEmail: $senderEmail, receiverId: $receiverId, message: $message, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirebaseMessageImpl &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderEmail, senderEmail) ||
                other.senderEmail == senderEmail) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, senderId, senderEmail, receiverId, message, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FirebaseMessageImplCopyWith<_$FirebaseMessageImpl> get copyWith =>
      __$$FirebaseMessageImplCopyWithImpl<_$FirebaseMessageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FirebaseMessageImplToJson(
      this,
    );
  }
}

abstract class _FirebaseMessage implements FirebaseMessage {
  const factory _FirebaseMessage(
      {required final String senderId,
      required final String senderEmail,
      required final String receiverId,
      required final String message,
      required final String timestamp}) = _$FirebaseMessageImpl;

  factory _FirebaseMessage.fromJson(Map<String, dynamic> json) =
      _$FirebaseMessageImpl.fromJson;

  @override
  String get senderId;
  @override
  String get senderEmail;
  @override
  String get receiverId;
  @override
  String get message;
  @override
  String get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$FirebaseMessageImplCopyWith<_$FirebaseMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
