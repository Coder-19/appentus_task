// the code below is used to create a class for getting the request from the user
// when the user tries to login
import 'package:appentus_flutter_task/database/database_controller.dart';
import 'package:appentus_flutter_task/models/user.dart';

class LoginRequest {
  // the code below is used to create an instance of the login controller
  DatabaseController loginController = DatabaseController();

  // the code below is used to create a method to login the user
  Future<User?> loginUser(String email, String password) async {
    // the below line of code is for debugging purpose
    print("Login request \n" + email + "\n" + password);
    // the code below is used to login the user and store the result
    var result = loginController.getLogin(email, password);

    // TODO: need to increse the value of id each time a new registeration is done and it has to be unique
    // var result = loginController.getSignUp(
    //     13, "Jasman", email, password, 1234567890.toString(), "test.png");
    // the code below is used to return the result
    return result;
  }
}
