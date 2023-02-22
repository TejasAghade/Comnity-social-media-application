import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comnity/models/post.dart';
import 'package:comnity/models/user_model.dart';
import 'package:comnity/resources/storage_methods.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload the post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async{
    String res = "some error occured";
    try{

      String photoUrl = await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = Uuid().v1();

      PostModel post = PostModel(
        description: description, 
        uid: uid, 
        username: username,
        postId: postId, 
        datePublished: DateTime.now(), 
        postUrl: photoUrl, 
        profImage: profImage, 
        likes: [], 
      );

      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    }catch(err){
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes, {required gestureLike}) async {
    try{
      if(likes.contains(uid)){

        if(!gestureLike){
          await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),

          });
        }

      }else{
         await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
          
        });
      }

    }catch(err){
      print(err.toString());
    }
  }

  Future<void> postComment(String postId, String text, String uid, String name, String profilePic) async{
    try{
      if(text.isNotEmpty){
        String commentId = const Uuid().v1();
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
          'profilePic' : profilePic,
          'text' : text,
          'name' : name,
          'uid' : uid,
          'datePublished' : DateTime.now()
        });
      }else{
        print("text is empty");
      }
    }catch(err){
      print(err.toString());
    }
  }

  // delete post
  Future<void> deletePost(String postId) async{
    try{
     await _firestore.collection('posts').doc(postId).delete();

    }catch(e){

    }

  }


    Future<void> followUser(
    String uid,
    String followId
  ) async {
    try {
      DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];
      
      if(following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }

    } catch(e) {
      print(e.toString());
    }
  }

  

}