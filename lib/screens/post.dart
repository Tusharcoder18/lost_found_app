import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lost_found_app/services/upload_service.dart';
import 'package:provider/provider.dart';

/*
This widget displays the details provided by the user such as the object's name 
description, images, found date, etc.
The user have to confirm the details are genuine. If yes then the next step
will upload these details to Firebase.
*/

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  String _name;
  String _description;
  String _category;
  List<File> _images = [];
  @override
  Widget build(BuildContext context) {
    final screemHeight = MediaQuery.of(context).size.height;
    _name = context.read<UploadService>().getName();
    _description = context.read<UploadService>().getDescription();
    _category = context.read<UploadService>().getCategory();
    _images = context.read<UploadService>().getImages();

    List<String> _titles = [
      "CarouselDummy",
      _name,
      "Description",
      "Founder's Details",
      "LocationDummy",
    ];
    List<String> _details = [
      "CarouselDummy",
      _category,
      _description,
      '''Name: Walter White\nPhone: 384799\nEmail: heisenberg@dea.com''',
      "LocationDummy",
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Final Preview!"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                color: Colors.white,
                onPressed: () async {
                  await context.read<UploadService>().uploadImages();
                  await context.read<UploadService>().uploadInfo();
                  print("Upload Successfull");
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.black),
                )),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: _titles.length,
          itemBuilder: (BuildContext context, int index) {
            // This will render the image carousel at the top of the column
            if (index == 0) {
              return Container(
                width: double.infinity,
                height: screemHeight * 0.3,
                child: CarouselSlider(
                  options: CarouselOptions(
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                  ),
                  items: List.generate(_images.length, (index1) {
                    return Image.file(
                      _images[index1],
                      fit: BoxFit.cover,
                    );
                  }),
                ),
              );
            }
            // This will render the location card at the end of the column
            if (index == (_titles.length - 1)) {
              return Material(
                elevation: 8.0,
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: screemHeight * 0.15,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          child: Center(
                        child: Text("Hyderabad"),
                      )),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        margin: EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.map,
                              color: Colors.black,
                            ),
                            onPressed: () {}),
                      )),
                    ],
                  ),
                ),
              );
            }
            // This will render the card multiple times which contains a title
            // and description
            return Material(
              elevation: 8.0,
              child: Container(
                margin: EdgeInsets.all(8.0),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _titles[index],
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _details[index],
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
