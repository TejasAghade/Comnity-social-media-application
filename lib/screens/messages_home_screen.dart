// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comnity/models/chat_model.dart';
import 'package:comnity/models/user_model.dart';
import 'package:comnity/resources/firebase_helper.dart';
import 'package:comnity/screens/chat_room_page.dart';
import 'package:comnity/screens/search_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MessagesHomeScreen extends StatefulWidget {
  const MessagesHomeScreen({super.key});

  @override
  State<MessagesHomeScreen> createState() => _MessagesHomeScreenState();
}

class _MessagesHomeScreenState extends State<MessagesHomeScreen> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  UserModel? userModel;
  getCurrentUser() async {
    userModel = await FirebaseHelper.getUserById(uid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text("Messages"),
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(FeatherIcons.search),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchMessages(),
                  ));
            },
          )
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .where('participants.${uid}', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                QuerySnapshot snap = snapshot.data as QuerySnapshot;

                return ListView.builder(
                  itemCount: snap.docs.length,
                  itemBuilder: (context, index) {
                    ChatModel chatModel = ChatModel.froMap(
                        snap.docs[index].data() as Map<String, dynamic>);
                    Map<String, dynamic> participants = chatModel.participants!;

                    List<String> participantsKeys = participants.keys.toList();
                    participantsKeys.remove(uid);

                    print(participantsKeys[0]);

                    return FutureBuilder(
                      future: FirebaseHelper.getUserById(participantsKeys[0]),
                      builder: (context, userData) {
                        if (userData.connectionState == ConnectionState.done) {
                          if (userData != null) {
                            UserModel targetUser = userData.data as UserModel;

                            return ListTile(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return  ChatRoomPage(
                                      targetUser: targetUser,
                                      chat: chatModel,
                                      firebaseUser:
                                          FirebaseAuth.instance.currentUser!,
                                      userModel: userModel!,
                                    );
                                  })
                                );
                              },
                              title: Text(targetUser.username.toString()),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    targetUser.photoUrl.toString()),
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              subtitle: Text( chatModel.lastMessage.toString() !=""?
                                chatModel.lastMessage.toString() : "Say Hi to your friend",
                                style: TextStyle(color: chatModel.lastMessage.toString() !=""? Colors.deepOrange: Colors.blueGrey),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("something goes wrong"),
                );
              } else {
                return Center(
                  child: Text("No Messages"),
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
    );
  }
}
