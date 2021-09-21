import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Dial(title: 'Flutter Demo Home Page'),
    );
  }
}

class Dial extends StatefulWidget {
  Dial({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Dial createState() => _Dial();
}

class _Dial extends State<Dial> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("${selectedDate.toLocal()}".split(' ')[0]),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
      onPressed: () => _selectDate(context),
    );
  }
}
