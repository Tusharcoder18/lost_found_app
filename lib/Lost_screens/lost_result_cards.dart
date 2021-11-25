import 'package:flutter/material.dart';

class LostCards extends StatefulWidget {
  const LostCards({Key key}) : super(key: key);

  @override
  _LostCardsState createState() => _LostCardsState();
}

class _LostCardsState extends State<LostCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Similar Items Found'),
      ),
      // body: ,
    );
  }
}
