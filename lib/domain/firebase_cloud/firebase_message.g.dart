// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirebaseMessageImpl _$$FirebaseMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$FirebaseMessageImpl(
      senderId: json['senderId'] as String,
      senderEmail: json['senderEmail'] as String,
      receiverId: json['receiverId'] as String,
      message: json['message'] as String,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$$FirebaseMessageImplToJson(
        _$FirebaseMessageImpl instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'senderEmail': instance.senderEmail,
      'receiverId': instance.receiverId,
      'message': instance.message,
      'timestamp': instance.timestamp,
    };
