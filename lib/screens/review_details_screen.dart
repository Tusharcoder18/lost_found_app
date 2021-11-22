import 'package:flutter/material.dart';
import 'package:lost_found_app/Models/Report.dart';
import 'package:lost_found_app/services/upload_service.dart';
import 'package:lost_found_app/widgets/custom_button.dart';
import 'package:lost_found_app/widgets/custom_textformfield.dart';
import 'package:provider/src/provider.dart';

/*
The review details screen allows the user to review the information and submit.
User can edit the data in the previous screens.
*/
class ReviewDetailsScreen extends StatefulWidget {
  @override
  _ReviewDetailsScreenState createState() => _ReviewDetailsScreenState();
}

class _ReviewDetailsScreenState extends State<ReviewDetailsScreen> {
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
    _title = context.read<Report>().getTitle();
    _category = context.read<Report>().getCategory();
    _value = context.read<Report>().getValue();
    _location = context.read<Report>().getLocation();
    _date = context.read<Report>().getDate();
    _timeFrom = context.read<Report>().getTimeFrom();
    _timeTo = context.read<Report>().getTimeTo();
    _uniqueInfo = context.read<Report>().getUniqueInfo();
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
              onTap: () async {
                context.read<Report>().setAnythingElse(_anythingElse);
                print(_anythingElse);
                await context
                    .read<UploadService>()
                    .uploadImages(context)
                    .then((value) => print("Images Uploaded"));
                await context.read<UploadService>().uploadReport(context);
                print("Upload Done");
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
