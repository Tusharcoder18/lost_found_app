import 'package:flutter/material.dart';
import 'package:lost_found_app/screens/uploadPage2.dart';
import 'package:lost_found_app/services/authentication_service.dart';
import 'package:provider/provider.dart';

/*
Sign out the user signed in using all the available methods.
And redirect to the default sign in screen.
*/
class SignOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationService>().signOutFromAll();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UploadPage()),
              );

              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
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
