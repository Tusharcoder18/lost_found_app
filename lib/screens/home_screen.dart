import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_found_app/screens/uploadPage.dart';
import 'package:lost_found_app/services/authentication_service.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  User _user;
  HomeScreen(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UploadPage()),
              );
            },
            child: Text("UploadPage"),
          ),
          Container(
            child: Center(
              child: MaterialButton(
                onPressed: () {
                  context.read<AuthenticationService>().signOutFromAll();
                },
                color: Colors.white,
                textColor: Colors.black,
                child: Text("Sign Out"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
