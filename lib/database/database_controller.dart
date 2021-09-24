// the code below is used to create a class for containing the methods for quering the
// data from the database for user login
import 'package:appentus_flutter_task/database/database_helper.dart';
import 'package:appentus_flutter_task/models/user.dart';

class DatabaseController {
  // the code below is used to create an instance of the database helper class
  DatabaseHelper databaseHelper = DatabaseHelper();

  // the code below is used to create a method to insert the data into the database
  Future<int> saveUser(User user) async {
    // the code below is used to get the access to the database
    var dbClient = await databaseHelper.db;
    // the code below is used to insert the user into the database using the insert method
    int result = await dbClient.insert("User",
        user.toMap()); // here we are inserting the values in the user table
    // the code below is used to return the result
    return result;
  }

  // the code below is used to create a method to delete the data from the database
  Future<int> deleteUser(User user) async {
    // the code below is used to get the access to the database
    var dbClient = await databaseHelper.db;
    // the code below is used to delete the user table from the database using the delete method
    int result = await dbClient.delete("User");
    // the code below is used to return the result
    return result;
  }

  // the code below is used to create a method for logging in the user
  Future<User?> getLogin(String email, String password) async {
    // the code below is used to get access to the database
    var dbClient = await databaseHelper.db;
    // the code below is used to check that whether the user exists in the database
    // or not

    // TODO: if any error occurs then check the query below
    var result = await dbClient.rawQuery(
        "SELECT * FROM user WHERE userEmail = '$email' and userPassword = '$password'");

    // the code below is used to check that if the length of the result is not empty
    // then retuning the result else returning null
    // ignore: prefer_is_empty
    if (result.length > 0) {
      print("LOGIN FUNCTION" + result.toString());
      // the code below is used to return the data of the user
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }

  // the code below is used to create a method for registering the user
  Future<int?> getSignUp(int id, String name, String email, String password,
      String phoneNumber, String image) async {
    // the code below is used to get access to the database
    var dbClient = await databaseHelper.db;
    // the code below is used to insert the data into the database
    var result = await dbClient.rawInsert(
        "INSERT INTO User(id,userName,userEmail,userPassword,userPhoneNumber,userImage) VALUES('$id','$name','$email','$password','$phoneNumber','$image')");
    // the code below is used to check that if the result is not empty then returning the result else
    // returning null

    // the below line of code is for debugging purpose
    print("The value after signup is: $result");

    return result;
  }

  // the code below is used to create a method to get the list of all the users
  Future<List<User>?> getAllUsers() async {
    // the code below is used to get access to the database
    var dbClient = await databaseHelper.db;
    // the code below is used to query the database
    var result = await dbClient.query("User");
    // the code below is used to get the list of all the users
    List<User>? userList =
        result.isNotEmpty ? result.map((c) => User.fromMap(c)).toList() : null;
    // the code below is used to return the list

// the below line of code is for  debugging purpose
    print("The list of users: ${userList!.length}");
    return userList;
  }

  // the code below is used to create a method to save the
  // image to the database as a string

  // TODO: need to save image as a string in sqlite
  Future<int?> savePhoto(String photo, String phoneNumber) async {
    // the code below is used to get access to the database
    var dbClient = await databaseHelper.db;
    var result = await dbClient.rawInsert(
        "INSERT INTO User(userImage) VALUES($photo) WHERE userPhoneNumber = '$phoneNumber'");
    return result;
  }

  // the code below is used to create a function to get the name based on the email address
  // of the user
  Future<User>? getUserName(String email) async {
    // the code below is used to create an instance of the db
    var dbClient = await databaseHelper.db;
    // the code below is used to get the user name from the db
    var result = await dbClient.rawQuery("SELECT userName FROM user WHERE userEmail = '$email'");
    // the below line of code is for debugging purpose
    print("Getting userName: ${result.first}");
    return User.fromMap(result.first);
  }

  // the code below is used to create a method for getting the image from the database
  Future<User>? getUserImage(String email) async {
    // the code below is used to create an instance of the db
    var dbClient = await databaseHelper.db;
    // the code below is used to get the user name from the db
    var result = await dbClient.rawQuery("SELECT userImage FROM user WHERE userEmail = '$email'");
    // the below line of code is for debugging purpose
    print("Getting userImage: ${result.first}");
    return User.fromMap(result.first);
  }
}
