import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_generated/user.freezed.dart';
part 'freezed_generated/user.g.dart';

@freezed
class User with _$User {

  const factory User({
    required String username,
    required String email,
    required String realName,
    required String profilePictureUrl,
    required String bio,
    required List<String> friendsUsernames,
    required String accountCreationDate,

  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}