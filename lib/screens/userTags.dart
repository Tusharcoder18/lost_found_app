import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lost_found_app/Models/User.dart';
import 'package:lost_found_app/screens/search_results.dart';

class ItemTags extends StatefulWidget {
  User _user;
  ItemTags(this._user);
  @override
  _ItemTagsState createState() => _ItemTagsState(_user);
}

class _ItemTagsState extends State<ItemTags> {
  User _user;
  _ItemTagsState(this._user);
  List<String> _dynamicChips = [
    'Money',
    'Food',
    'Mobile',
    'LongLongKeyword',
    'Short',
    'Virus'
  ]; //add items later

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> _tags = []; //selected tags will be added here

  final db = FirebaseStorage.instance;

  SnackBar snackBar = SnackBar(
    content: Text('Please Select Atleast one Relevent Tag!'),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 3),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            child: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
            ),
            onPressed: () {
              if (_tags.isNotEmpty)
                db
                    .ref(_user.uid)
                    .child("Tags")
                    .putString(_tags[0]); //TODO: Change here Firebase exoerts
              print("Pushed Successfully!");
              if (_tags.isNotEmpty)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchResults()),
                );
              if (_tags.isEmpty)
                _scaffoldKey.currentState.showSnackBar(snackBar);
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        // margin: EdgeInsets.all(30),
        padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(children: [
          Divider(
            thickness: 5,
            color: Colors.deepPurple,
          ),
          RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        fontSize: 20,
                      ),
                  children: [
                TextSpan(
                    text: 'Tell us something about it\n',
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                TextSpan(text: 'Go ahead and add tags below!'),
              ])),
          SizedBox(height: 50),
          Container(
              // color: Colors.transparent,
              width: 300,
              height: 300,
              child: Wrap(
                children: companyWidgets.toList(),
              )),
          SizedBox(height: 170),
          Divider(
            thickness: 5,
            color: Colors.deepPurple,
          ),
        ]),
      ),
    );
  }

  Iterable<Widget> get companyWidgets sync* {
    bool select = false;
    for (String name in _dynamicChips) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          backgroundColor: Colors.deepPurple,
          selectedColor: Colors.green,
          avatar: Icon(Icons.add),
          label: Text(name),
          selected: _tags.contains(name),
          onSelected: (selected) {
            setState(() {
              select = !select;
              if (selected) {
                _tags.add(name);
              } else {
                _tags.removeWhere((String names) {
                  return names == name;
                });
              }
            });
          },
        ),
      );
    }
  }
}
