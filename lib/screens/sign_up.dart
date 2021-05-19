import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lost_found_app/services/authentication_service.dart';
import 'package:lost_found_app/screens/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:lost_found_app/screens/categories.dart';

/*
The main purpose of this widget is to take user input required for sign up such
as Phone No, password, etc. and use these details to sign up the user.
*/
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _phone;
  String _password;
  String _confirmPassword;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // This is for signUp
    final firebaseUser = context.watch<User>();

    // If user sign in is successful, then this will push to the HomeScreen()
    if (firebaseUser != null) {
      return HomeScreen();
    }

    // If user is not signed in then this sign in page will be displayed
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            _headerWidget(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            _formWidget(),
          ],
        ),
      ),
    );
  }

  // This widget contains the title of the app and the logo(if any)
  Widget _headerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Lost Found",
          style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 30),
        ),
        Container(
          height: 70,
          child: Icon(FontAwesomeIcons.search),
        ),
      ],
    );
  }

  /*
  This widget contains three form fields for user details
  The user details used for user sign up are
  1) Phone Number
  2) Password
  */
  Widget _formWidget() {
    return Form(
      key: _formKey,
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Phone Number form field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      labelText: "Phone Number"),
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Phone Number is Required";
                    }
                  },
                  onChanged: (String value) {
                    _phone = value;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),

              // Password form field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      labelText: "Password"),
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Password is Required";
                    }
                  },
                  onChanged: (String value) {
                    _password = value;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // Confirm password form field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      labelText: "Confirm Password"),
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Password is Required";
                    } else if (_password != _confirmPassword) {
                      return "Password did not match";
                    }
                  },
                  onChanged: (String value) {
                    _confirmPassword = value;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),

              // Sign up custom button
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () {
                  if (_password == _confirmPassword) {
                    print("password Confirmed");
                    print(context.read<AuthenticationService>().signUp(
                          email: _phone,
                          password: _password,
                        ));
                  } else {
                    print("password Not Confirmed");
                  }

                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  print(_phone);
                  print(_password);
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[600]),
                    borderRadius: BorderRadius.circular(3)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sign up',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
                textColor: Colors.white,
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Need Help?",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                child: Text(
                  "Already a user? Sign in now.",
                  style: Theme.of(context).textTheme.headline2,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
// Widget
}
