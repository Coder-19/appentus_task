// the code below is used to create an abstract class for listening to the callbacks
// when the user tries to login
import 'package:appentus_flutter_task/login_helper/login_request.dart';
import 'package:appentus_flutter_task/models/user.dart';

abstract class LoginCallback {
  // the code below is used to create the signature of the method for login success
  void onLoginSuccess(User? user);
  // the code below is used to create the signature of the method for login error
  void onLoginError(String error);
}

// the code below is used to create a class for getting the response from the database
// when the user tries to login
class LoginResponse {
  // the code below is used to create an instance of login callback
  final LoginCallback? _loginCallback;
  // the code below is used to create an instance of login request
  LoginRequest loginRequest = LoginRequest();

  // the code below is used to create a constructor for login response
  LoginResponse(this._loginCallback);

  // the code below is used to create a method to login the user
  doLogin(String email, String password) {
    loginRequest.loginUser(email, password).then((user) {
      if (user != null) {
        // _loginCallback!.onLoginSuccess(user);
        // the below line of code is for debugging purpose
        print("The User email is: $user \n The password is: $user");
      } else {
        // the below line of code is for debugging purpose
        print("Either email or password is null");
      }
    }).catchError((error) {
      _loginCallback!.onLoginError(error.toString());
      // the below line of code is for debugging purpose
      print("The error is: ${error.toString()}");
    });
  }
}
