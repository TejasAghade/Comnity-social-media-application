// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:html';

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comnity/models/chat_model.dart';
import 'package:comnity/models/message_model.dart';
import 'package:comnity/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:uuid/uuid.dart';

class ChatRoomPage extends StatefulWidget {
  final UserModel targetUser;
  final ChatModel chat;
  final User firebaseUser;
  final UserModel userModel;

  const ChatRoomPage(
      {super.key,
      required this.targetUser,
      required this.chat,
      required this.firebaseUser,
      required this.userModel});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  TextEditingController _messageController = TextEditingController();

  void sendMessages() async {
    String message = _messageController.text.trim();
    _messageController.clear();

    if (message != "") {
      // send message

      MessageModel newMessage = MessageModel(
          messageId: Uuid().v1(),
          sender: widget.userModel.uid,
          createdOn: DateTime.now(),
          text: message,
          seen: false);

      FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chat.chatId)
          .collection('messages')
          .doc(newMessage.messageId)
          .set(newMessage.toMap());

      widget.chat.lastMessage = message;
      FirebaseFirestore.instance.collection('chats').doc(widget.chat.chatId).set(widget.chat.toMap());
      log("messge sent");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        // centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.targetUser.photoUrl),
              radius: 18,
            ),
            SizedBox(
              width: 10,
            ),
            Text(widget.targetUser.username),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: EdgeInsets.only(bottom: 10),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .doc(widget.chat.chatId)
                      .collection('messages')
                      .orderBy("createdOn", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot snap = snapshot.data as QuerySnapshot;

                        return ListView.builder(
                          reverse: true,
                          itemCount: snap.docs.length,
                          itemBuilder: (context, index) {
                            MessageModel currentMessage = MessageModel.fromMap(
                                snap.docs[index].data()
                                    as Map<String, dynamic>);
                            return Row(
                              mainAxisAlignment: currentMessage.sender == widget.userModel.uid? MainAxisAlignment.end : MainAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.symmetric(vertical: 3),
                                    decoration: BoxDecoration(
                                      color: currentMessage.sender == widget.userModel.uid? Colors.deepOrange.shade400 : Colors.amberAccent.shade100,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(currentMessage.text.toString(), style: TextStyle(color: currentMessage.sender == widget.userModel.uid? Colors.white : Colors.black),)),
                              ],
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("no internet connection"),
                        );
                      } else {
                        return Center(
                          child: Text("Say Hi to your friend"),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
            Container(
              color: Colors.deepOrange.shade100,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: _messageController,
                          maxLines: null,
                          cursorColor: Colors.deepOrange,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Message..."),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        sendMessages();
                      },
                      icon: Icon(FeatherIcons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
