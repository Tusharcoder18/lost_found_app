import 'dart:io';

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
  int imageCount = -1;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

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
                child: CarouselSlider(
                    options: CarouselOptions(),
                    items: (imageCount >= 0)
                        ? file
                            .map(
                              (item) => Container(
                                child: Image.file(
                                  File(item.path),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                            .toList()
                        : [
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  final pickedFile = await _picker.getImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 100,
                                  );
                                  Provider.of<UploadService>(context,
                                          listen: false)
                                      .uploadImage(
                                          image: File(file[imageCount].path),
                                          name: "file");
                                  setState(() {
                                    file[++imageCount] = pickedFile;
                                  });
                                } catch (e) {
                                  setState(() {
                                    print(e);
                                  });
                                }
                              },
                              child: Text('Click to add image'),
                            )
                          ]),
              ),
              childCount: file.isEmpty ? 1 : (file.length + 1),
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
          ),
        ],
      ),
    );
  }
}
