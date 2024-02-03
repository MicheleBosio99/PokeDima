import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_message.freezed.dart';
part 'firebase_message.g.dart';

@freezed
class FirebaseMessage with _$FirebaseMessage {

  const factory FirebaseMessage({
    required String senderId,
    required String senderEmail,
    required String receiverId,
    required String message,
    required String timestamp,

  }) = _FirebaseMessage;

  factory FirebaseMessage.fromJson(Map<String, dynamic> json) => _$FirebaseMessageFromJson(json);
}