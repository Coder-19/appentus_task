// the code below is used to create a class for getting the login details of
// the user
import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier{
  // the code below is used to create a property for getting the email of the user
  String? email;

  // the code below is used to save the email address of the user
  void saveEmailAddress(String userEmail){
    email = userEmail;
    notifyListeners();
  }
}