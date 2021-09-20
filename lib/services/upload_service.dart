import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';

/*
This service class is used to provide upload services to the app.
The upload services mainly include uploading the images for lost objects and
also uploading the info about the uploader and the lost object.
*/

class UploadService {
  String _name;
  String _email;
  String _phone;
  String _description;
  String _category;
  DateTime _date;
  List<String> _imageUrls = [];
  List<File> _images = [];

  final Reference _storageReference =
      FirebaseStorage.instance.ref().child("images");
  final FirebaseFirestore _firestoreReference = FirebaseFirestore.instance;

  // Uploads multiple images to the Firebase Storage and stores the imageurls
  // for future use
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
    } catch (e) {
      print(e);
    }
  }

  // Setters
  void setCategory(String category) {
    _category = category;
  }

  void setName(String name) {
    _name = name;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPhone(String phone) {
    _phone = phone;
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
        'name': _name ?? '',
        'email': _email ?? '',
        'phone': _phone ?? '',
        'description': _description ?? '',
        'category': _category ?? ['Others'],
        'images': _imageUrls ?? [''],
        'date': _date.toString().split(" ")[0],
      }).then((value) => print("Data pushed to firebase"));
    } catch (e) {
      print(e);
    }
  }
}
