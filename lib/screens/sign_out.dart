import 'package:flutter/material.dart';
import 'package:lost_found_app/screens/uploadPage2.dart';
import 'package:lost_found_app/services/authentication_service.dart';
import 'package:provider/provider.dart';

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
              Navigator.pop(context);
=======
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UploadPage()),
              );
>>>>>>> 3c65d7089d91b6ff6bb25e778463e3361064f914:lib/screens/home_screen.dart
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
