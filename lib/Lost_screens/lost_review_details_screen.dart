import 'package:flutter/material.dart';
import 'package:lost_found_app/Models/Report.dart';
import 'package:lost_found_app/Models/Search.dart';

import 'package:lost_found_app/widgets/custom_button.dart';
import 'package:lost_found_app/widgets/custom_textformfield.dart';
import 'package:provider/src/provider.dart';

/*
The review details screen allows the user to review the information and submit.
User can edit the data in the previous screens.
*/
class LostReviewDetailsScreen extends StatefulWidget {
  @override
  _LostReviewDetailsScreenState createState() =>
      _LostReviewDetailsScreenState();
}

class _LostReviewDetailsScreenState extends State<LostReviewDetailsScreen> {
  String _anythingElse;
  String _title = "DUMMYTEXT";
  String _category = "DUMMYTEXT";
  String _value = "DUMMYTEXT";
  String _location = "DUMMYTEXT";
  String _date = "DUMMYTEXT";
  String _timeTo = "DUMMYTEXT";
  String _timeFrom = "DUMMYTEXT";
  String _uniqueInfo = "DUMMYTEXT";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _title = context.read<Search>().getTitle();
    _category = context.read<Search>().getCategory();
    _value = context.read<Search>().getValue();
    _location = context.read<Search>().getLocation();
    _date = context.read<Search>().getDate();
    _timeFrom = context.read<Search>().getTimeFrom();
    _timeTo = context.read<Search>().getTimeTo();
    _uniqueInfo = context.read<Search>().getUniqueInfo();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Review and Submit")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Valuable Details",
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 20),
            ),
            SizedBox(height: 8.0),
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.3,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    "Previously Uploaded Images",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text("Title/Name/Brand: " + _title),
            SizedBox(height: 5.0),
            Text("Category: " + _category),
            SizedBox(height: 5.0),
            Text("Monetary Value: " + _value),
            SizedBox(height: 5.0),
            Text("Location: " + _location),
            SizedBox(height: 5.0),
            Text("Time: " + _timeFrom + " - " + _timeTo),
            SizedBox(height: 5.0),
            Text("Something Unique for Identification: " + _uniqueInfo),
            SizedBox(height: 10.0),
            CustomTextFormField(
              context,
              title: "Anything Else?",
              keyboardType: TextInputType.text,
              validator: (value) {
                return "";
              },
              onChanged: (value) {
                _anythingElse = value;
              },
              maxLines: 5,
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            CustomButton(
              onTap: () {
                context.read<Search>().setAnythingElse(_anythingElse);
                print(_anythingElse);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Container()));
              },
              color: Colors.white,
              text: "Submit",
              style: TextStyle(color: Colors.black),
              icon: Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
    );
  }
}
