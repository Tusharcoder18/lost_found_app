import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:lost_found_app/Models/Report.dart';

/*
This service class is used to provide upload services to the app.
The upload services mainly include uploading the images for lost objects and
also uploading the info about the uploader and the lost object.
*/

class UploadService {
  // String _name;
  // String _email;
  // String _phone;
  // String _description;
  // String _category;
  // DateTime _date;
  // List<String> _imageUrls = [];
  // List<File> _images = [];

  final Reference _storageReference =
      FirebaseStorage.instance.ref().child("images");
  final FirebaseFirestore _firestoreReference = FirebaseFirestore.instance;

  // Uploads multiple images to the Firebase Storage and stores the imageurls
  // for future use
  Future<void> uploadImages(BuildContext context) async {
    try {
      // print("Paths of images:-");
      // for (int i = 0; i < _images.length; i++) {
      //   print(_images[i].path);
      // }
      Report _report = context.read<Report>();
      final _images = _report.getImages();
      final _title = _report.getTitle();
      final _date = _report.getDate();
      for (int i = 0; i < _images.length; i++) {
        File image = _images[i];
        String name = _title.toString() + _date.toString() + i.toString();
        String _imageUrl;
        UploadTask uploadTask = _storageReference.child(name).putFile(image);
        TaskSnapshot imageSnapshot = (await uploadTask);
        _imageUrl = (await imageSnapshot.ref.getDownloadURL());
        print("Image Url:- " + _imageUrl);
        _report.setImageUrls(_imageUrl);
      }
    } catch (e) {
      print(e);
    }
  }

  /*
  Uploads the important information of the uploader and the lost object
  to the Firebase Firestore
  Note: Also uploads the image urls which is a list of multiple images of
  the lost object
  */
  Future<void> uploadReport(BuildContext context) async {
    Report _report = context.read<Report>();
    final _imageUrls = _report.getImageUrls();

    try {
      print(_imageUrls);
      _firestoreReference.collection("reports").add({
        'title': _report.getTitle() ?? '',
        'category': _report.getCategory() ?? '',
        'value': _report.getValue() ?? '',
        'location': _report.getLocation() ?? '',
        'date': _report.getDate() ?? '',
        'timeTo': _report.getTimeTo() ?? '',
        'timeFrom': _report.getTimeFrom() ?? '',
        'uniqueInfo': _report.getUniqueInfo() ?? '',
        'anythingElse': _report.getAnythingElse() ?? '',
        'imageUrls': _report.getImageUrls() ?? '',
      }).then((value) => print("Report uploaded"));
    } catch (e) {
      print(e);
    }
  }
}