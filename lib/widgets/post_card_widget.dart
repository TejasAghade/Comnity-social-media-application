// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comnity/models/user_model.dart';
import 'package:comnity/providers/user_provider.dart';
import 'package:comnity/resources/firestore_methods.dart';
import 'package:comnity/screens/comment_screen.dart';
import 'package:comnity/utils/colors.dart';
import 'package:comnity/utils/utils.dart';
import 'package:comnity/widgets/like_animation.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class PostCardWidget extends StatefulWidget {
  final snap;

  const PostCardWidget({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {

  bool isLikeAnimating = false;
  int commentLenght = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
  }

  void getComments() async{
     try{
      QuerySnapshot snap = await FirebaseFirestore.instance.collection('posts').doc(widget.snap['postId']).collection('comments').get();

        commentLenght = snap.docs.length;

     }catch(e){
      showSnackBar(e.toString(), context);
     }
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: const [
          BoxShadow(
            color: primaryShadow,
            offset: Offset(0.0, 0.0),
            blurRadius: 10.0,
            spreadRadius: 0.5,
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.95,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // profile image
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.snap['profImage']),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.snap['username'],
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) => Dialog(
                        child: ListView(
                          padding: 
                          const EdgeInsets.symmetric(
                            vertical: 16
                            ),
                          shrinkWrap: true,
                          children: [
                            'delete'
                          ]
                          .map((e) => InkWell(
                            onTap: () async{
                              FirestoreMethods().deletePost(widget.snap['postId']);
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Text(e.toString()),
                            ),
                          )
                          ).toList(),
                        ),
                        
                      )
                     );
                    }, 
                    icon: Icon(EvaIcons.moreHorizontal))
                ],
              ),
              Divider(
                color: Colors.grey.shade200,
              ),
              GestureDetector(
                onDoubleTap: () async{
                  await FirestoreMethods().likePost(
                    widget.snap['postId'],
                    user.uid,
                    widget.snap['likes'],
                    gestureLike: true
                  );
                  setState(() {
                    isLikeAnimating = true;
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 350,
                      ),
                      child: Image.network(
                        widget.snap['postUrl'],
                        // width: MediaQuery.of(context).size.width*0.8,
                        width: double.infinity,
                        // height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isLikeAnimating ? 1 : 0,
                      child: LikeAnimation(
                        child: const Icon(
                          LineIcons.heartAlt, size: 100, color: Colors.white), 
                          isAnimating: isLikeAnimating, duration: const Duration(milliseconds: 400),
                          onEnd: (){
                            setState(() {
                              print("false");
                              isLikeAnimating = false;
                            });
                          },
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.shade200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      LikeAnimation(
                        isAnimating: widget.snap['likes'].contains(user.uid),
                        smallLike: true,
                        child: IconButton(
                          onPressed: () async{
                            await FirestoreMethods().likePost(
                            widget.snap['postId'],
                            user.uid,
                            widget.snap['likes'],
                            gestureLike: false
                          );
                          setState(() {
                            isLikeAnimating = true;
                          });
                        }, 
                        icon: widget.snap['likes'].contains(user.uid)? Icon(LineIcons.heartAlt, color: Colors.red,) : Icon(LineIcons.heart)
                        
                        )
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CommentScreen(snap: widget.snap,) )
                            );
                          },
                          icon: Icon(FeatherIcons.messageSquare)
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(FeatherIcons.send),
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {}, icon: Icon(FeatherIcons.bookmark))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // likes count
                    Text(
                      "${widget.snap['likes'].length} likes",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    RichText(
                        text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            children: [
                          TextSpan(
                            text: widget.snap['username'],
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: " ${widget.snap['description']}",
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ])),
                    const SizedBox(
                      height: 5,
                    ),
                    // recent comments
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "view all ${commentLenght} comments",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       "@nik",
                    //       style: TextStyle(
                    //           fontSize: 13, fontWeight: FontWeight.bold),
                    //     ),
                    //     SizedBox(
                    //       width: 3,
                    //     ),
                    //     Text(
                    //       "wow",
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      DateFormat.yMMMd().format(widget.snap['datePublished'].toDate()),
                      style: TextStyle(
                        fontSize: 8,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
