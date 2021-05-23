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
  List<PickedFile> file = List<PickedFile>();
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
        onPressed: () {},
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
                                file[imageCount] = pickedFile;
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
                        options: CarouselOptions(),
                        items: file
                            .map(
                              (item) => Container(
                                child: Image.file(
                                  File(item.path),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                            .toList()),
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
                  color: Colors.red,
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'ItemTitle',
                          decoration: InputDecoration(labelText: 'Title'),
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
                          decoration: InputDecoration(labelText: 'Description'),
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
                          decoration: InputDecoration(labelText: 'Found On'),
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
                          decoration: InputDecoration(labelText: 'Location'),
                          onChanged: (value) {
                            uploader.setEmail(value);
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 70),
                          ]),
                          keyboardType: TextInputType.streetAddress,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber),
                            ),
                            child: Text('Submit'),
                            onPressed: () {
                              uploader.uploadInfo();
                            },
                          ),
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
