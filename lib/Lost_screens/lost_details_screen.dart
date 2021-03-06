import 'package:flutter/material.dart';
import 'package:lost_found_app/Lost_screens/lost_result_cards.dart';
import 'package:lost_found_app/Models/Report.dart';
import 'package:lost_found_app/Models/Search.dart';

import 'package:lost_found_app/screens/review_details_screen.dart';
import 'package:lost_found_app/widgets/custom_button.dart';
import 'package:lost_found_app/widgets/custom_textformfield.dart';
import 'package:provider/src/provider.dart';

import 'lost_review_details_screen.dart';

/*
The More details screen asks the user for more information related to the found
valuable such as Title, Monetary Value, Unique characteristic of valuable.
*/

class LostDetailsScreen extends StatefulWidget {
  @override
  State<LostDetailsScreen> createState() => _LostDetailsScreenState();
}

class _LostDetailsScreenState extends State<LostDetailsScreen> {
  String _title;
  String _value;
  String _uniqueInfo;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add more details!'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              CustomTextFormField(
                context,
                title: 'Title/Name/Brand',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please enter some text";

                  return null;
                },
                onChanged: (value) {
                  _title = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                context,
                title: 'Monetary Value/Worth(In Rupees)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please enter some text";
                  if (num.tryParse(value) == null)
                    return "Please enter a number";

                  return null;
                },
                onChanged: (value) {
                  _value = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                context,
                title: 'Tell someting unique for Identification purpose',
                keyboardType: TextInputType.text,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please enter some text";

                  return null;
                },
                onChanged: (value) {
                  _uniqueInfo = value;
                },
              ),
              SizedBox(height: screenHeight * 0.3),
              CustomButton(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    context.read<Search>().setValue(_value);
                    context.read<Search>().setUniqueInfo(_uniqueInfo);
                    context.read<Search>().setTitle(_title);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LostCards()));
                  }
                },
                color: Colors.white,
                text: "Search",
                style: TextStyle(color: Colors.black),
                icon: Icon(Icons.navigate_next),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
