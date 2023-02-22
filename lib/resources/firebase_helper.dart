import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comnity/models/user_model.dart';

class FirebaseHelper{
  static Future<UserModel?> getUserById(String uid) async{

    UserModel? userModel;

    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if(snap.data()!= null){
      userModel = UserModel.fromJson(snap.data() as Map<String, dynamic>);
      
    }
    return userModel;
  }
}