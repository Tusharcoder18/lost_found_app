import 'package:flutter/material.dart';
import 'package:lost_found_app/screens/categories.dart';

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
      appBar: AppBar(),
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
                      MaterialPageRoute(builder: (context) => Categories()));
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
