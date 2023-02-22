// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comnity/models/user_model.dart';
import 'package:comnity/providers/user_provider.dart';
import 'package:comnity/resources/firestore_methods.dart';
import 'package:comnity/widgets/comments_card.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({super.key, required this.snap});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final UserModel user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text("Comments"),
          centerTitle: true,
          foregroundColor: Colors.black,
        ),
        
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .orderBy('datePublished', descending: true)
          .snapshots(),

          builder: ((context,  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){

            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount:  snapshot.data!.docs.length,
              itemBuilder: ((context, index) =>CommentCard(
                // snap: (snapshot.data! as dynamic).docs[index].data()
                snap: snapshot.data?.docs[index].data()
              )),
            );

          }),

        ),

        bottomNavigationBar: SafeArea(
          child: Container(
            height: kToolbarHeight,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.photoUrl,
                  ),
                  radius: 18,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left:18.0, right: 8),
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: "Comment as ${user.username}",
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async{
                    await FirestoreMethods().postComment(
                      widget.snap['postId'], 
                      _commentController.text,
                      user.uid, 
                      user.username, 
                      user.photoUrl
                    );
                    setState(() {
                      _commentController.text ="";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 9),                    
                    child: Text("post", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}