// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:comnity/models/user_model.dart';
import 'package:comnity/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key, required this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
   final UserModel user = Provider.of<UserProvider>(context).getUser;
   
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profilePic']),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                    children: [
                      TextSpan(text: "${widget.snap['name']} ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                      TextSpan(text: "${widget.snap['text']}", style: TextStyle(color: Colors.black)),
                    ]
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(DateFormat.yMMMd().format(widget.snap['datePublished'].toDate()), style: TextStyle(fontSize: 8),),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Icon(FeatherIcons.heart, size: 12,),
          )
        ],
      ),
    );
  }
}