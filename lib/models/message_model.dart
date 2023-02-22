// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  String messageId;
  String sender;
  String text;
  bool seen;
  DateTime createdOn;
  MessageModel({
    required this.messageId,
    required this.sender,
    required this.text,
    required this.seen,
    required this.createdOn,
  });
  



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'sender': sender,
      'text': text,
      'seen': seen,
      'createdOn': createdOn.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'] as String,
      sender: map['sender'] as String,
      text: map['text'] as String,
      seen: map['seen'] as bool,
      createdOn: DateTime.fromMillisecondsSinceEpoch(map['createdOn'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(messageId: $messageId, sender: $sender, text: $text, seen: $seen, createdOn: $createdOn)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.messageId == messageId &&
      other.sender == sender &&
      other.text == text &&
      other.seen == seen &&
      other.createdOn == createdOn;
  }

  @override
  int get hashCode {
    return messageId.hashCode ^
      sender.hashCode ^
      text.hashCode ^
      seen.hashCode ^
      createdOn.hashCode;
  }
}
