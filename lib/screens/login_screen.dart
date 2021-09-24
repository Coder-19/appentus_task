import 'package:appentus_flutter_task/database/database_controller.dart';
import 'package:appentus_flutter_task/login_helper/login_request.dart';
import 'package:appentus_flutter_task/login_helper/login_response.dart';
import 'package:appentus_flutter_task/models/user.dart';
import 'package:appentus_flutter_task/provider/login_provider.dart';
import 'package:appentus_flutter_task/screens/home_screen.dart';
import 'package:appentus_flutter_task/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// the code below is used to create the login screen of the app
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  // the code below is used to create a constructor for the LoginScreen
  // const LoginScreen(
  //   Key? key,
  // ) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// the code below is used to create an enumerate constant for checking whether the
// user is signed in or not
enum LoginStatus {
  notSignIn,
  signIn,
}

class _LoginScreenState extends State<LoginScreen> implements LoginCallback {
  // the code below is used to initialize the loginStatus emun
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  // the code below is used to create a variable of type build context
  BuildContext? _context;
  // the code below is used to create a property for checking that whether the data is being sent
  // to the database or not
  bool loading = false;
  // the code below is used to create a Global form key
  final formKey = GlobalKey<FormState>();
  // the code below is used to create the global scaffold key
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // the code below is used to create a property for getting the email of the user
  String? _email;
  // the code below is used to create a proeprty for getting the user password
  String? _password;
  // the code below is used to create an instance of the login response
  LoginResponse? _loginResponse;
  // the code below is used to create a property for getting the login status value
  // ignore: prefer_typing_uninitialized_variables
  var value;

  // the code below is used to initialize the LoginScreen State class
  _LoginScreenState() {
    _loginResponse = LoginResponse(this);
  }

  // the code below is used to create a submit method to submit the data entered by
  // the user in the text field
  // void submit() {
  //   // the code below is used to create a property for getting the current form state
  //   final form = formKey.currentState;

  //   // the code below is used to validate the form
  //   if (form!.validate()) {
  //     setState(() {
  //       loading = true;
  //       // the code below is used to save the form
  //       form.save();
  //       // after saving the form doing the login
  //       _loginResponse!.doLogin(_email.toString(), _password.toString());
  //     });
  //   }
  // }

  // the code below is used to create a method to show the snackbar
  void _showSnackBar(String text) {
    scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(text)));
  }

  // getPref() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     value = preferences.getInt("value");

  //     _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
  //   });
  // }

  // the code below is used to create a method for sign out
  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      // the below line of code is for debugging purpose
      print("Inside signOut() method");

      // TODO: if any error occurs then remove the line of code below
      preferences.setInt("value", 0);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void onLoginError(String error) {
    // // the code below is used to show the snack bar if any error occurs
    // _showSnackBar(error);
    // setState(() {
    //   loading = false;
    // });
  }

  // the code below is used to create a method for saving the data entered by the user
  // savePref(int value, String user, String pass) async {
  //   // the code below is used to create an instance of the shared preferences
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     preferences.setInt("value", value);
  //     preferences.setString("user", user);
  //     preferences.setString("pass", pass);
  //     preferences.commit();
  //   });
  // }

  @override
  void onLoginSuccess(User? user) async {
    // if (user != null) {
    //   savePref(1, user.userName, user.userPassword);
    //   _loginStatus = LoginStatus.signIn;
    // } else {
    //   _showSnackBar("Login Success");
    //   setState(() {
    //     loading = false;
    //   });
    // }
  }

  // using the initState() method below
  @override
  void initState() {
    super.initState();

    // calling the getPref() method below
    // getPref();
  }

  @override
  Widget build(BuildContext context) {
    // the code below is to use the switch case to check the login status
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        context = context;
        // the code below is used to create a login button when the user is not logged in
        var loginButton = ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  loading = true;

                  // the code below is used to create an instance of the db controller
                  DatabaseController db = DatabaseController();

                  db.getAllUsers();

                  LoginRequest loginRequest = LoginRequest();

                  // loginRequest
                  //     .loginUser(_email.toString(), _password.toString())
                  db.getLogin(_email.toString(), _password.toString()).then((value) {
                    if (value != null) {
                      Provider.of<LoginProvider>(context,listen: false).saveEmailAddress(_email.toString());

                      // the below line of code for debugging prurpose
                      print("The email address entered by the user is: ${Provider.of<LoginProvider>(context,listen: false).email}");
                      _showSnackBar("User $value is logged in");
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return const HomeScreen();
                          }));
                    } else {
                      _showSnackBar("Error");
                    }
                  });
                  //         .then((value) {
                  //   DatabaseController db = DatabaseController();
                  //   db.getAllUsers().then((value) {
                  //     if (value != null) {
                  //       Navigator.of(context).pushReplacement(
                  //           MaterialPageRoute(builder: (context) {
                  //         return const HomeScreen();
                  //       }));
                  //     }
                  //   });
                  // });
                  // the code below is used to save the form
                  // form.save();
                  // after saving the form doing the login
                  // _loginResponse!
                  //     .doLogin(_email.toString(), _password.toString());
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
                    "Login",
                  ),
                ),
              ),
            ),
          ),
        );
        // the code below is used to create a form for the user when the user is not logged in
        var loginForm = Column(
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
                          _email = value;
                          print(_email);
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      decoration: const InputDecoration(labelText: "Email"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                          print(_password);
                        });
                      },
                      onSaved: (val) {
                        setState(() {
                          _password = val;
                        });
                      },
                      decoration: const InputDecoration(labelText: "Password"),
                    ),
                  )
                ],
              ),
            ),
            loginButton,

            const SizedBox(
              height: 20.0,
            ),

            // the code below is used to create a text to take the user to the
            // signup screen
            Center(
              child: GestureDetector(
                // TODO: need to add the onTap functionality
                onTap: (){
                  // the navigator below is used to take the user to the
                  // signup  screen
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const SignupScreen();
                  }));
                },
                child: const Text(
                  // ignore: unnecessary_string_escapes
                  "Don\'t have an account? SignUp",
                ),
              ),
            ),
          ],
        );
        return Scaffold(
          appBar: AppBar(
            title: const Text("Login Page"),
          ),
          key: scaffoldKey,
          // ignore: avoid_unnecessary_containers
          body: Container(
            child: SingleChildScrollView(
              child: Center(
                child: loginForm,
              ),
            ),
          ),
        );
      case LoginStatus.signIn:
        return HomeScreen(
          onTapSignOut: signOut,
        );
    }
  }
}
