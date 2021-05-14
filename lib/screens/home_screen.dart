import 'package:flutter/material.dart';
import 'package:lost_found_app/services/authentication_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
    );
  }
}