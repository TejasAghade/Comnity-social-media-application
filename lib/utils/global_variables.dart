import 'package:comnity/screens/add_post_Screen.dart';
import 'package:comnity/screens/feed_screen.dart';
import 'package:comnity/screens/messages_home_screen.dart';
import 'package:comnity/screens/profile_screen.dart';
import 'package:comnity/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;
bool isAdminGlobal = false;

 List<Widget> homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  MessagesHomeScreen(),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
];