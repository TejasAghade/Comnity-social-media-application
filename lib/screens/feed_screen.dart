// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comnity/widgets/post_card_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool isFollowersLoaded = false;

  var userSnap;

  List followingIds = [];

  var userData = {};

  getUserFollowing() async {
    var userSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    userData = userSnap.data()!;

    setState(() {
      followingIds = userData['following'];
      followingIds.add(userData['uid']);
      isFollowersLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserFollowing();
  }

  @override
  Widget build(BuildContext context) {
    return isFollowersLoaded
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              // title: Text("Comnity", style: TextStyle(color: Colors.black),),
              title: SvgPicture.asset("assets/svg/Comnity2.svg",
                  width: 90, color: Colors.deepOrange.shade300),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0.2,
            ),
            body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .where('uid', whereIn: followingIds)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data!.docs.length > 0) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) => PostCardWidget(
                        snap: snapshot.data?.docs[index].data(),
                      ),
                    );
                  }else if(snapshot.hasError){
                    return Center(child: Text("something goes wrong restart application"),);
                  }
                  else{
                    return Center(child: Text("Follow Peoples to see posts"),);
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
