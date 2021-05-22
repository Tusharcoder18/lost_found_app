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
  List<String> _tags;
  List<String> _imageUrls;

  final Reference _storageReference =
      FirebaseStorage.instance.ref().child("images");
  final FirebaseFirestore _firestoreReference = FirebaseFirestore.instance;

  // Uploads the selected file to the Firebase Storage and stores the imageurl
  // for future use
  Future<void> uploadImage({File image, String name}) async {
    try {
      String _imageUrl;
      UploadTask uploadTask = _storageReference
          .child(name)
          .putFile(image, SettableMetadata(contentType: "image/jpeg"));
      TaskSnapshot imageSnapshot = (await uploadTask);
      _imageUrl = (await imageSnapshot.ref.getDownloadURL());
      _imageUrls.add(_imageUrl);
    } catch (e) {
      print(e);
    }
  }

  // Setters
  void setTags(List<String> tags) {
    _tags = tags;
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

  // Please add the getters here in case needed

  /*
  Uploads the important information of the uploader and the lost object
  to the Firebase Firestore
  Note: Also uploads the image urls which is a list of multiple images of
  the lost object
  */
  Future<void> uploadInfo() async {
    try {
      _firestoreReference.collection("info").add({
        'name': _name ?? '',
        'email': _email ?? '',
        'phone': _phone ?? '',
        'description': _description ?? '',
        'tags': _tags ?? ['Others'],
        'images': _imageUrls ?? [''],
      }).then((value) => print("Data pushed to firebase"));
    } catch (e) {
      print(e);
    }
  }

  void setCategory(String category) {}
}
