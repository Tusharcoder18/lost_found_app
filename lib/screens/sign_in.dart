import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lost_found_app/screens/home_screen.dart';
import 'package:lost_found_app/services/authentication_service.dart';
import 'package:lost_found_app/screens/sign_up.dart';
import 'package:provider/provider.dart';

/*
The main purpose of this widget is to check wether the user is signed in or not.
If the user is signed in then it will push to the Homescreen else the main sign
in screen will be displayed.

Note: If the user is signed in on the first launch of the app then it will 
automatically redirect to the homescreen the second time.
*/

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _phone;
  String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    // If user sign in is successful, then this will push to the HomeScreen()
    if (firebaseUser != null) {
      return HomeScreen(firebaseUser);
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
  This widget contains two form fields and two buttons
  It contains three options for user sign in 
  1) Sign in with phone and password
  2) Sign in using Google account
  3) Sign in using Facebook account(Optional)
  */
  Widget _formWidget() {
    return Form(
      key: _formKey,
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    print(_phone);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                  onSaved: (String value) {
                    _password = value;
                  },
                  onChanged: (String value) {
                    _password = value;
                    print(_password);
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  print(_phone);
                  print(_password);
                  context.read<AuthenticationService>().signIn(
                        email: _phone,
                        password: _password,
                      );
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[600]),
                    borderRadius: BorderRadius.circular(3)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sign in',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
                textColor: Colors.white,
              ),
              SizedBox(
                height: 15,
              ),
              CustomButton(
                  text: "Sign-in using Google",
                  icon: Icon(FontAwesomeIcons.google),
                  color: Colors.red,
                  onTap: () {
                    print('User Details:');
                    print(context
                        .read<AuthenticationService>()
                        .signInWithGoogle());
                  }),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                  text: "Sign-in using Facebook",
                  icon: Icon(FontAwesomeIcons.facebook),
                  color: Colors.blue,
                  onTap: () {
                    print(context
                        .read<AuthenticationService>()
                        .signInWithFacebook());
                  }),
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
                  "New to Lost Found? Sign up now.",
                  style: Theme.of(context).textTheme.headline2,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
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
}

// Custom button takes multiple arguments to render the desired button
class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Icon icon;
  final Color color;
  final Function onTap;
  CustomButton({this.text, this.icon, this.color, this.style, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      minWidth: double.maxFinite,
      height: 50,
      onPressed: () {
        if (onTap != null) {
          onTap();
        }
      },
      color: color != null ? color : Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon != null ? icon : Icon(FontAwesomeIcons.sign),
          SizedBox(width: 10),
          Text(text,
              style: style != null
                  ? style
                  : Theme.of(context).textTheme.headline1),
        ],
      ),
      textColor: color != Colors.white ? Colors.white : Colors.black,
    );
  }
}
