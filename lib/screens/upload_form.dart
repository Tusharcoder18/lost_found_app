import 'dart:io';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_found_app/screens/post.dart';
import 'package:lost_found_app/services/upload_service.dart';
import 'package:lost_found_app/widgets/form_decorator.dart';
import 'package:provider/provider.dart';

class UploadForm extends StatefulWidget {
  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  List<PickedFile> images = [];
  DateTime _dateTime;
  int imageCount = 0, index = 0;
  final _formKey = GlobalKey<FormBuilderState>();
  final ImagePicker _picker = ImagePicker();
  var rng = new Random();

  @override
  Widget build(BuildContext context) {
    final List<String> _labels = [
      "Title",
      "Description",
      "Found On(Date)",
      "Location",
    ];
    final List<Function> _onChanged = [
      (String value) => context.read<UploadService>().setName(value),
      (String value) => context.read<UploadService>().setDescription(value),
      (DateTime value) => context.read<UploadService>().setDate(value),
      (String value) => context.read<UploadService>().setEmail(value),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        elevation: 50,
        onPressed: () async {
          _formKey.currentState.save();
          if (_formKey.currentState.validate()) {
            // If the form validates successfully then upload the images and the
            // info of the post
            // await context.read<UploadService>().uploadImages();
            // await context.read<UploadService>().uploadInfo();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Post()));
          } else {
            // If the form doesn't validate then show a snackbar with the
            // required message
            SnackBar snackBar =
                SnackBar(content: Text("Please fill the required details!"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
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
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              final pickedFile = await _picker.getImage(
                                source: ImageSource.gallery,
                                imageQuality: 100,
                              );
                              setState(() {
                                context
                                    .read<UploadService>()
                                    .setImages(File(pickedFile.path));
                                images.add(pickedFile);
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
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                                scrollDirection: Axis.horizontal,
                                enableInfiniteScroll: false),
                            items: images
                                .map(
                                  (item) => Image.file(
                                    File(item.path),
                                    fit: BoxFit.cover,
                                  ),
                                )
                                .toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  final pickedFile = await _picker.getImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 100,
                                  );
                                  setState(() {
                                    context
                                        .read<UploadService>()
                                        .setImages(File(pickedFile.path));
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
                        ],
                      ),
              ),
              childCount: 1,
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
                    autovalidateMode: AutovalidateMode.always,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(_labels.length, (index) {
                        if (index == 2) {
                          return FormBuilderDateTimePicker(
                            name: 'date',
                            inputType: InputType.date,
                            initialDate: DateTime.now(),
                            decoration: formDecorator('Found On(Date)'),
                            enabled: true,
                            onChanged: (date) {
                              print(date.toString().split(" ")[0]);
                              _onChanged[index](date);
                            },
                            validator: FormBuilderValidators.required(context),
                          );
                        }
                        return FormBuilderTextField(
                          name: 'ItemTitle',
                          decoration: formDecorator(_labels[index]),
                          onChanged: (value) {
                            _onChanged[index](value);
                          },
                          validator: FormBuilderValidators.required(context),
                          keyboardType: TextInputType.name,
                        );
                      }),
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