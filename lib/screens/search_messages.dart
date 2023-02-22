// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comnity/models/chat_model.dart';
import 'package:comnity/models/user_model.dart';
import 'package:comnity/screens/chat_room_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:uuid/uuid.dart';

class SearchMessages extends StatefulWidget {
  const SearchMessages({super.key});

  @override
  State<SearchMessages> createState() => _SearchMessagesState();
}

class _SearchMessagesState extends State<SearchMessages> {
  final TextEditingController _searchController = TextEditingController();

  var userSnap;
  late UserModel userModel;
  List followingIds = [];

  var userData = {};

  Future<ChatModel?> getChatroomModel(UserModel targetUser) async {
    ChatModel? chatroom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chats')
        .where('participants.${userModel.uid}', isEqualTo: true)
        .where('participants.${targetUser.uid}', isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      // fetch existing
      log('Chat Already Exist');

      var docData = snapshot.docs[0].data();
      ChatModel existingChatroom =
          ChatModel.froMap(docData as Map<String, dynamic>);
      chatroom = existingChatroom;
    } else {
      // creating new one
      ChatModel newChatModel = ChatModel(
        chatId: Uuid().v1(),
        lastMessage: "",
        participants: {
          userModel.uid.toString(): true,
          targetUser.uid.toString(): true,
        },
      );

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(newChatModel.chatId)
          .set(newChatModel.toMap());

      chatroom = newChatModel;

      log("new chat created");
    }

    return chatroom;
  }

  getUserFollowing() async {
    var userSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    userData = userSnap.data()!;

    setState(() {
      followingIds = userData['following'];
      followingIds.add(userData['uid']);

      userModel = UserModel(
          email: userSnap['email'],
          uid: userSnap['uid'],
          photoUrl: userSnap['photoUrl'],
          username: userSnap['username'],
          bio: userSnap['bio'],
          followers: userSnap['followers'],
          following: userSnap['following'],
        );
    });
  }

  @override
  void initState() {
    super.initState();
    getUserFollowing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 310,
                height: 40,
                child: CupertinoSearchTextField(
                  controller: _searchController,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      // border: BorderRadius.circular(50)
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FeatherIcons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('username', isNotEqualTo:  FirebaseAuth.instance.currentUser!.uid)
                .where('username', isGreaterThanOrEqualTo: _searchController.text)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot snap = snapshot.data as QuerySnapshot;

                  if (snap.docs.isNotEmpty) {
                    Map<String, dynamic> userMap = snap.docs[0].data() as Map<String, dynamic>;

                    UserModel searchedUser = UserModel.fromJson(userMap);

                    return ListTile(
                      onTap: () async {
                        ChatModel? chatRoomModel =
                            await getChatroomModel(searchedUser);

                        if (chatRoomModel != null) {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatRoomPage(
                                  targetUser: searchedUser,
                                  firebaseUser:
                                      FirebaseAuth.instance.currentUser!,
                                  userModel: userModel,
                                  chat: chatRoomModel,
                                ),
                              ));
                        }
                      },
                      title: Text(searchedUser.username.toString()),
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(searchedUser.photoUrl.toString()),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    );
                  } else {
                    return Center(child: Text("no data found"));
                  }
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Something goes wrong"),
                  );
                } else {
                  return Center(
                    child: Text("No User Found"),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
