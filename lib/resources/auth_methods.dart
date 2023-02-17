import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comnity/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:comnity/models/user_model.dart' as userModel;

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<userModel.UserModel> getUserDetails() async{
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();
    return userModel.UserModel.fromSnap(snap);
    
  }

  Future<String> signupUser({
    required String email, 
    required String password, 
    required String username, 
    required String bio,
    required Uint8List file,
    }) async{
      String res = "some error occured";

      try{
        

        if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty || file.isNotEmpty ){
          // register user
          UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

          String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

          userModel.UserModel user = userModel.UserModel(
            username:username,
            uid:cred.user!.uid,
            email : email,
            bio : bio,
            followers:[],
            following:[],
            photoUrl : photoUrl
          );

          // add user to database
          await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

          res = "success";
        }

      } on FirebaseAuthException catch(err) {
        if(err.code == 'invalid-email'){
          res = 'The email is badly formatted';
        }
        if(err.code == 'weak-password'){
          res = 'Password should be 6 character long';
        }
      }
      
      catch(err){
        res = err.toString();
      }
      return res;

  }


  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

}