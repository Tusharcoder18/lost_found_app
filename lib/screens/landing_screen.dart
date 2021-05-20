import 'package:flutter/material.dart';
import 'package:lost_found_app/screens/sign_out.dart';

/*
Successfully authenticated users will be redirected to the Landing screen. 
Landing screen provides the user with two options for further navigation. 
1) LOST - proceeds to the lost home screen
2) FOUND - guides the user to register a lost object
*/
class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              // Lost button
              Expanded(
                  child: MaterialButton(
                onPressed: () {},
                color: Colors.black,
                textColor: Colors.white,
                child: Center(
                  child: Text(
                    "LOST",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              )),
              // Found button
              Expanded(
                  child: MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignOut()));
                },
                color: Colors.white,
                child: Center(
                  child: Text(
                    "FOUND",
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: Colors.black),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
