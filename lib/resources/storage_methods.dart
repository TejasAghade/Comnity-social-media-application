import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMethods{
  FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // add image to firebase
  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async{

    
    Reference ref =  _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if(isPost){
      String id = Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file, SettableMetadata(contentType: 'image/jpeg'));

    TaskSnapshot snap = await uploadTask;

    String donwloadUrl = await snap.ref.getDownloadURL();
    
    return donwloadUrl;

  }

}