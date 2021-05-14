import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_found_app/screens/upload_images.dart';
import 'package:lost_found_app/screens/userTags.dart';
import 'package:lost_found_app/services/authentication_service.dart';

class HomeScreen extends StatelessWidget {
  User _user;
  HomeScreen(this._user);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      // builder: (context) => ItemTags(_user)
                      //TODO: Get User instance using Provider.......
                      ));
            },
            child: Container(
              alignment: Alignment.center,
              width: 300,
              height: 200,
              margin: EdgeInsets.all(25),
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Lost ',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.white)),
                  Icon(
                    Icons.search,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 5,
            color: Colors.blueGrey,
            endIndent: 40,
            indent: 40,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UploadImages()
                      //TODO: Get user instance in above line.......
                      ));
            },
            child: Container(
              alignment: Alignment.center,
              width: 300,
              height: 200,
              margin: EdgeInsets.all(25),
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Found ',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.white)),
                  Icon(
                    Icons.favorite_border,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 5,
            color: Colors.blueGrey,
            endIndent: 40,
            indent: 40,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: FlatButton(
          //       color: Colors.deepPurple,
          //       onPressed: () {
          //         _auth.signOut();
          //       },
          //       child: Text(
          //         'Sign Out',
          //         style: Theme.of(context)
          //             .textTheme
          //             .headline3
          //             .copyWith(color: Colors.white),
          //       )),
          // ),
        ],
      ),
    );
  }
}
