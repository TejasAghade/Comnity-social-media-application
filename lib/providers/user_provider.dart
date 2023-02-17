import 'package:comnity/models/user_model.dart';
import 'package:comnity/resources/auth_methods.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier{

  final AuthMethods _authMethods = AuthMethods();
  UserModel? _user;

  UserModel get getUser => _user!;

  Future<void> refreshUser() async{
    UserModel user = await _authMethods.getUserDetails();
    _user = user;
    
    notifyListeners(); 

  }

}