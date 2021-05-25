import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_found_app/services/upload_service.dart';
import 'package:provider/provider.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  List<PickedFile> file = [];
  int imageCount = 0, index = 0;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  UploadService uploader = UploadService();
  var rng = new Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        elevation: 50,
        onPressed: () {
          uploader.uploadInfo();
        },
        child: Icon(
          Icons.done_rounded,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Tell us more !"),
            expandedHeight: 50,
            floating: true,
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                child: (imageCount == 0)
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              final pickedFile = await _picker.getImage(
                                source: ImageSource.gallery,
                                imageQuality: 100,
                              );
                              uploader.uploadImage(
                                  image: File(pickedFile.path),
                                  name: "file" +
                                      rng.nextInt(1002130213).toString());
                              setState(() {
                                // file[imageCount] = pickedFile; This is only valid if the length is specified in the list declaration
                                file.add(pickedFile);
                                print("ImageCount: $imageCount");
                                imageCount++;
                                print("ImageCount: $imageCount");
                              });
                            } catch (e) {
                              setState(() {
                                print(e);
                              });
                            }
                          },
                          child: Text('Click to add image'),
                        ),
                      )
                    : CarouselSlider(
                        options:
                            CarouselOptions(scrollDirection: Axis.horizontal),
                        items: file
                            .map(
                              (item) => Container(
                                child: Image.file(
                                  File(item.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                            .toList(),
                      ),
              ),
              childCount: file == null ? 1 : (file.length + 1),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  // color: Colors.red,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.red),
                  child: FormBuilder(
                    key: _formKey,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FormBuilderTextField(
                          name: 'ItemTitle',
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            border: new OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: new BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                borderSide: BorderSide(color: Colors.white)),
                            // hintText: 'Enter Title',
                            labelText: 'Title',
                            isDense: true,
                          ),
                          onChanged: (value) {
                            uploader.setName(value);
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 70),
                          ]),
                          keyboardType: TextInputType.name,
                        ),
                        FormBuilderTextField(
                          name: 'ItemTitle',
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            border: new OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: new BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                borderSide: BorderSide(color: Colors.white)),
                            // hintText: 'Enter Title',
                            labelText: 'Description',
                            isDense: true,
                          ),
                          onChanged: (value) {
                            uploader.setDescription(value);
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 250),
                          ]),
                          keyboardType: TextInputType.multiline,
                        ),
                        FormBuilderTextField(
                          name: 'ItemTitle',
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            border: new OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: new BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                borderSide: BorderSide(color: Colors.white)),
                            // hintText: 'Enter Title',
                            labelText: 'Found On',
                            isDense: true,
                          ),
                          onChanged: (value) {
                            uploader.setPhone(value);
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 70),
                          ]),
                          keyboardType: TextInputType.datetime,
                        ),
                        FormBuilderTextField(
                          name: 'ItemTitle',
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            border: new OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: new BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                borderSide: BorderSide(color: Colors.white)),
                            // hintText: 'Enter Title',
                            labelText: 'Location',
                            isDense: true,
                          ),
                          onChanged: (value) {
                            uploader.setEmail(value);
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 70),
                          ]),
                          keyboardType: TextInputType.streetAddress,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
