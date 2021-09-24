import 'dart:convert';
import 'dart:io';
import 'package:appentus_flutter_task/database/database_controller.dart';
import 'package:appentus_flutter_task/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// the code below is used to create a signup screen for the app
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  // the code below is used to create a proeprty for creating a global form key
  final formKey = GlobalKey<FormState>();

  // the code below is used to create  a property for getting the name of the user
  String? name;

  // the code below is used to create a property for getting the number of the user
  String? number;

  // the code below is used to create a property for getting the email of the user
  String? email;

  // the code below is used to create  a property for getting the password of the
  // user
  String? password;

  // the code below is used to create a proeprty to get the image path of the user
  String? imagePath;

  // the code below is used to create a property for getting the image as a file
  File? _image;

  // the code below is used to get the value of id
  int id = 0;

  // the code below is used to create a method to get the image from the gallery
  _imgFromGallery() async {
    // ignore: invalid_use_of_visible_for_testing_member
    PickedFile? image = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = File(image!.path);
    });

    // the code below is used to convert the image to bytes
    final bytes = await _image!.readAsBytes();

      // the below line of code for debugging purpose
      print("The encoded image is: ${base64.encode(bytes)}");

      setState(() {
        imagePath = base64.encode(bytes);
      });

      // the below line of code is  for debugging purpose
    print("The encoded image to be saved is: $imagePath");
      return base64.encode(bytes);
  }



@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Signup Page"),
    ),
    // ignore: avoid_unnecessary_containers
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });

                      // the below line of code is for debugging purpose
                      print("The name entered by the user is: $name");
                    },
                    onSaved: (value) {

                    },
                    decoration: const InputDecoration(labelText: "Name"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        number = value;
                      });

                      // the below line of code is for debugging purpose
                      print("The phone number entered is: $number");
                    },
                    onSaved: (value) {

                    },
                    decoration: const InputDecoration(labelText: "Number"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });

                      // the below line of code is for debugging purpose
                      print("The email entered by the user: $email");
                    },
                    onSaved: (value) {

                    },
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        password =value;
                      });

                      // the below line of code is for debugging purpose
                      print("The password entered by the user is: $password");
                    },
                    onSaved: (val) {

                    },
                    decoration: const InputDecoration(labelText: "Password"),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // the code below is used to create a button to upload the image
                // of the user
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Center(
                    child: GestureDetector(
                      // TODO: need to add the onTap functionality
                      onTap: () {
                        _imgFromGallery();
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.teal,
                        ),
                        child: const Center(
                          child: Text(
                            "Upload Image",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Center(
              child: GestureDetector(
                // TODO: need to add the onTap functionality
                onTap: () {
                  // the code below is used to create an instance of the
                  // database controller
                  DatabaseController db = DatabaseController();

                  // the code below is used to call the get signup method to
                  // signup the user
                  db.getSignUp(id++, name.toString(), email.toString(), password.toString(), number.toString(), imagePath.toString()).then((value) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return const LoginScreen();
                    }));
                  });
                },
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.teal,
                  ),
                  child: const Center(
                    child: Text(
                      "Signup",
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 20.0,
          ),

          // the code below is used to create a text to take the user to the
          // login screen
          Center(
            child: GestureDetector(
              // TODO: need to add the onTap functionality
              onTap: (){
                // the navigator below is used to take the user to the
                // signup  screen
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return const LoginScreen();
                }));
              },
              child: const Text(
                // ignore: unnecessary_string_escapes
                "Already have an account? Login",
              ),
            ),
          ),
        ],
      ),
    ),
  );
}}
