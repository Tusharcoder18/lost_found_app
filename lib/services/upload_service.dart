import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';

/*
This service class is used to provide upload services to the app.
The upload services mainly include uploading the images for lost objects and
also uploading the info about the uploader and the lost object.
*/

class UploadService {
  String _title;
  String _email;
  String _phone;
  String _description;
<<<<<<< HEAD
  String _category;
  DateTime _date;
  List<String> _imageUrls = [];
  List<File> _images = [];
=======
  DateTime _dateTime;
  List<String> _tags;
  List<String> _imageUrls = [];
>>>>>>> bdcef9d096ebf36e3c6fd7732d2926335a8954b7

  final Reference _storageReference =
      FirebaseStorage.instance.ref().child("images");
  final FirebaseFirestore _firestoreReference = FirebaseFirestore.instance;

  // Uploads multiple images to the Firebase Storage and stores the imageurls
  // for future use
<<<<<<< HEAD
  Future<void> uploadImages() async {
    try {
      for (int i = 0; i < _images.length; i++) {
        File image = _images[i];
        String name = _name + i.toString();
        String _imageUrl;
        UploadTask uploadTask = _storageReference
            .child(name)
            .putFile(image, SettableMetadata(contentType: "image/jpeg"));
        TaskSnapshot imageSnapshot = (await uploadTask);
        _imageUrl = (await imageSnapshot.ref.getDownloadURL());
        _imageUrls.add(_imageUrl);
      }
=======
  Future<void> uploadImage({File image, String title}) async {
    try {
      String _imageUrl;
      UploadTask uploadTask = _storageReference
          .child(title)
          .putFile(image, SettableMetadata(contentType: "image/jpeg"));
      TaskSnapshot imageSnapshot = (await uploadTask);
      _imageUrl = (await imageSnapshot.ref.getDownloadURL());
      _imageUrls.add(_imageUrl);
>>>>>>> bdcef9d096ebf36e3c6fd7732d2926335a8954b7
    } catch (e) {
      print(e);
    }
  }

  // Setters
  void setTags(List<String> tags) {
    _tags = tags;
  }

  void setTitle(String title) {
    _title = title;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPhone(String phone) {
    _phone = phone;
  }

  void setDate(DateTime dateTime) {
    _dateTime = dateTime;
  }

  void setDescription(String description) {
    _description = description;
  }

  void setDate(DateTime date) {
    _date = date;
  }

  void setImages(File image) {
    _images.add(image);
  }

  // Please add the getters here in case needed
  String getName() {
    return _name;
  }

  String getDescription() {
    return _description;
  }

  String getCategory() {
    return _category;
  }

  List<File> getImages() {
    return _images;
  }

  /*
  Uploads the important information of the uploader and the lost object
  to the Firebase Firestore
  Note: Also uploads the image urls which is a list of multiple images of
  the lost object
  */
  Future<void> uploadInfo() async {
    try {
      print(_imageUrls);
      _firestoreReference.collection("info").add({
        'title': _title ?? '',
        'email': _email ?? '',
        'phone': _phone ?? '',
        'date': _dateTime ?? '',
        'description': _description ?? '',
        'tags': _tags ?? ['Others'],
        'images': _imageUrls ?? [''],
<<<<<<< HEAD
        'date': _date.toString().split(" ")[0],
      }).then((value) => print("Data pushed to firebase"));
=======
      }).then((value) => print("Data pushed to firebase $value"));
>>>>>>> bdcef9d096ebf36e3c6fd7732d2926335a8954b7
    } catch (e) {
      print(e);
    }
  }

  void setCategory(String category) {}
}
