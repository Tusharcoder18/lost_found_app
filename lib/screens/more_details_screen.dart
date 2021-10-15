import 'package:flutter/material.dart';
import 'package:lost_found_app/widgets/custom_button.dart';
import 'package:lost_found_app/widgets/custom_textformfield.dart';

/*
The More details screen asks the user for more information related to the found
valuable such as Title, Monetary Value, Unique characteristic of valuable.
*/

class MoreDetailsScreen extends StatefulWidget {
  @override
  State<MoreDetailsScreen> createState() => _MoreDetailsScreenState();
}

class _MoreDetailsScreenState extends State<MoreDetailsScreen> {
  String _title;
  String _worth;
  String _unique_details;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add more details!'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CustomTextFormField(
                context,
                title: 'Title/Name/Brand',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please enter some text";

                  return "";
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

                  return "";
                },
                onChanged: (value) {
                  _worth = value;
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

                  return "";
                },
                onChanged: (value) {
                  _unique_details = value;
                },
              ),
              Expanded(child: SizedBox()),
              CustomButton(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Container()));
                },
                color: Colors.white,
                text: "Next",
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
