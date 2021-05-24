import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_found_app/services/upload_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  PickedFile file;
  int imageCount = 0;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var pickImageButton = SizedBox(
      height: MediaQuery.of(context).size.height * .35,
      width: 300,
      child: ElevatedButton.icon(
          onPressed: () async {
            try {
              final pickedFile = await _picker.getImage(
                source: ImageSource.gallery,
                imageQuality: 90,
              );
              setState(() {
                file = pickedFile;
              });
            } catch (e) {
              setState(() {
                print(e);
              });
            }
            UploadService().uploadImage();
          },
          icon: Icon(Icons.add_a_photo_rounded),
          label: Text("Click to add image")),
    );
    var addImageButton = ElevatedButton.icon(
      onPressed: () async {
        setState(() {
          imageCount++;
        });
        try {
          final pickedFile = await _picker.getImage(
            source: ImageSource.gallery,
            imageQuality: 100,
          );
          setState(() {
            file = pickedFile;
          });
        } catch (e) {
          setState(() {
            print(e);
          });
        }
      },
      icon: Icon(Icons.add_a_photo_outlined),
      label: Text("Click to upload Image"),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Tell us more!",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [],
      ),
      extendBody: true,
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Container(
              padding: EdgeInsets.all(10),
              // margin: EdgeInsets.all(5),
              color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.35,
              child: (file == null)
                  ? addImageButton
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          viewImages(),
                          addImageButton,
                        ],
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.54,
            child: ListView(
              children: [
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
                            UploadService().setName(value);
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 70),
                          ]),
                          keyboardType: TextInputType.number,
                        ),
                        FormBuilderTextField(
                          name: 'ItemTitle',
                          decoration: InputDecoration(labelText: 'Description'),
                          onChanged: (value) {
                            UploadService().setDescription(value);
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 250),
                          ]),
                          keyboardType: TextInputType.number,
                        ),
                        FormBuilderTextField(
                          name: 'ItemTitle',
                          decoration: InputDecoration(labelText: 'Found On'),
                          onChanged: (value) {
                            UploadService().setPhone(value);
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 70),
                          ]),
                          keyboardType: TextInputType.number,
                        ),
                        FormBuilderTextField(
                          name: 'ItemTitle',
                          decoration: InputDecoration(labelText: 'Location'),
                          onChanged: (value) {
                            UploadService().setEmail(value);
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 70),
                          ]),
                          keyboardType: TextInputType.number,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber),
                            ),
                            child: Text('Submit'),
                            onPressed: () {
                              UploadService().uploadInfo();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ignore: missing_return
  Container viewImages() {
    for (int i = 0; i <= imageCount; i++) {
      return Container(
        margin: EdgeInsets.all(3),
        child: Image.file(
          File(file.path),
          fit: BoxFit.fill,
        ),
      );
    }
  }
}
