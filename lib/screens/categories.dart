import 'package:flutter/material.dart';
import 'package:lost_found_app/services/authentication_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Colors.grey, Colors.grey[600]])),
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
              CustomListTile(Icons.person, 'profile', () => {}),
              CustomListTile(Icons.notifications, 'Notification', () => {}),
              CustomListTile(Icons.settings, 'Settings', () => {}),
              CustomListTile(
                  Icons.logout,
                  'Logout',
                  () =>
                      {context.read<AuthenticationService>().signOutFromAll()}),
              CustomListTile(Icons.help, 'Help!', () => {})
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Choose a Category"),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: [
            InkWell(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.grey[500],
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.directions_car,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 130, left: 82),
                      child: Text("LOL"),
                    )
                  ],
                ),
              ),
              onTap: () {},
            ),
            InkWell(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.grey[500],
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.face,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 130, left: 82),
                      child: Text("LOL"),
                    )
                  ],
                ),
              ),
              onTap: () {},
            ),
          ],
        ));
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
