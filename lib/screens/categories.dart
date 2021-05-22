import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Choose a Category"),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: [
            CustomCards(Icons.directions_car, 'LOL', () => {}),
            CustomCards(Icons.face, 'LOL', () => {})
          ],
        ));
  }
}

// ignore: must_be_immutable
class CustomCards extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;
  CustomCards(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.grey[500],
        child: Stack(
          children: [
            Center(
              child: Icon(
                icon,
                size: 50,
                color: Colors.black,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 130, left: 82),
              child: Text(text),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
