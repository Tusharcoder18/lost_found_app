import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_found_app/screens/categories.dart';
import 'package:lost_found_app/services/upload_service.dart';
import 'package:lost_found_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

/*
  "Found" functionality users will be redirected to the Image Upload Screen.
  Users can select single or multiple images of the Found object in this screen.
*/
class ImageScreen extends StatefulWidget {
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  List<PickedFile> images = [];
  int imageCount = 0, index = 0;
  final ImagePicker _picker = ImagePicker();

  // Shows a dialog to select single or multiple images
  void _pickImages() async {
    try {
      final pickedFile = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      setState(() {
        context.read<UploadService>().setImages(File(pickedFile.path));
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
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Select images"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Select image box
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
              child: GestureDetector(
                onTap: _pickImages,
                child: (imageCount == 0)
                    ? DottedBorder(
                        strokeCap: StrokeCap.round,
                        borderType: BorderType.RRect,
                        dashPattern: [6, 8],
                        color: Colors.white,
                        strokeWidth: 3,
                        child: SizedBox(
                          width: screenWidth * 0.75,
                          height: screenHeight * 0.3,
                          child: Icon(
                            Icons.upload,
                            size: screenWidth * 0.1,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: screenWidth * 0.75,
                        height: screenHeight * 0.3,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            scrollDirection: Axis.horizontal,
                            enableInfiniteScroll: false,
                            autoPlay: true,
                          ),
                          items: images
                              .map(
                                (item) => Image.file(
                                  File(item.path),
                                  fit: BoxFit.cover,
                                ),
                              )
                              .toList(),
                        ),
                      ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: screenHeight * 0.2,
              ),
            ),
            CustomButton(
              onTap: _pickImages,
              color: Colors.white,
              text: "Add images",
              style: TextStyle(color: Colors.black),
              icon: Icon(Icons.add),
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Categories()));
              },
              color: Colors.white,
              text: "Next",
              style: TextStyle(color: Colors.black),
              icon: Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
    );
  }
}
