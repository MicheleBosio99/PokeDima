// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      username: json['username'] as String,
      email: json['email'] as String,
      realName: json['realName'] as String,
      profilePictureUrl: json['profilePictureUrl'] as String,
      bio: json['bio'] as String,
      favouriteColor: json['favouriteColor'] as String,
      friendsUsernames: (json['friendsUsernames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      accountCreationDate: json['accountCreationDate'] as String,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'realName': instance.realName,
      'profilePictureUrl': instance.profilePictureUrl,
      'bio': instance.bio,
      'favouriteColor': instance.favouriteColor,
      'friendsUsernames': instance.friendsUsernames,
      'accountCreationDate': instance.accountCreationDate,
    };
