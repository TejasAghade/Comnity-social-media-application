import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;
  final bool? isAdmin;

  UserModel( { required this.email,  required this.uid,  required this.photoUrl,  required this.username,  required this.bio,  required this.followers,  required this.following, this.isAdmin });

  Map<String, dynamic> toJson()=>{
    "username" : username,
    "uid" : uid,
    "email" : email,
    "photoUrl" : photoUrl,
    "bio" : bio,
    "followers" : followers,
    "following" : following,
    "isAdmin" : isAdmin,
  };

  static UserModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email : snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      bio : snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      isAdmin: snapshot['isAdmin']
    );
  }

      factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        uid: json["uid"],
        email: json["email"],
        photoUrl: json["photoUrl"],
        bio: json["bio"],
        followers: json["followers"],
        following: json["following"],
        isAdmin: json["isAdmin"],
    );


}