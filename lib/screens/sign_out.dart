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
<<<<<<< HEAD:lib/screens/sign_out.dart
              context.read<AuthenticationService>().signOutFromAll();
<<<<<<< HEAD
              Navigator.pop(context);
=======
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UploadPage()),
              );
>>>>>>> 3c65d7089d91b6ff6bb25e778463e3361064f914:lib/screens/home_screen.dart
=======
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
>>>>>>> 8620f38a1c27de3ad17e8fac4ef49c1bcb5df1c5
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
