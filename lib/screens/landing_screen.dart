import 'package:flutter/material.dart';
import 'package:lost_found_app/Lost_screens/Lost_categories.dart';
import 'package:lost_found_app/services/authentication_service.dart';
import 'package:provider/provider.dart';
import 'select_image_screen.dart';

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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.black87, Colors.grey])),
              child: Container(
                child: Column(
                  children: [
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/hoob.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            CustomListTile(Icons.logout, 'Logout',
                () => {context.read<AuthenticationService>().signOutFromAll()}),
            CustomListTile(Icons.help, 'Help!', () => {})
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              // Lost button
              Expanded(
                  child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LostCategories()));
                },
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
                      MaterialPageRoute(builder: (context) => ImageScreen()));
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

// ignore: must_be_immutable
class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;
  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[400]))),
        child: InkWell(
          splashColor: Colors.grey[600],
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
