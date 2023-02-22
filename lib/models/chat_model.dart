// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class ChatModel {
  String? chatId;
  Map<String, dynamic>? participants;
  String? lastMessage;

  ChatModel({
    this.chatId,
    this.participants,
    this.lastMessage,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'participants': participants,
      'lastMessage': lastMessage,
    };
  }

  ChatModel.froMap(Map<String, dynamic> map){
    chatId = map['chatId'];
    participants = map['participants'];
    lastMessage = map['lastMessage'];
  }

  String toJson() => json.encode(toMap());



  @override
  int get hashCode => chatId.hashCode ^ participants.hashCode;
}
