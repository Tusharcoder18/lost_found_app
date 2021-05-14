import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lost_found_app/Models/User.dart';
import 'package:lost_found_app/Models/image_upload.dart';
import 'package:lost_found_app/screens/userTags.dart';

class Uploader extends StatefulWidget {
  final List<Object> images;
  final User user;

  Uploader({Key key, this.images, this.user}) : super(key: key);

  createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  var event;
  dynamic _uploadTask;
  String filePath = 'images';
  final FirebaseStorage _storage = FirebaseStorage.instance;

  _startUpload() {
    setState(() {
      for (int index = 0; index < widget.images.length; index++) {
        if (widget.images[index] is ImageUploadModel) {
          ImageUploadModel file = widget.images[index] as ImageUploadModel;
          File myImage = file.imageFile;
          _uploadTask = _storage
              .ref()
              .child(
                  'found_images/${widget.user.uid}/${UniqueKey().toString()}')
              .putFile(myImage);
        }
      }
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ItemTags(widget.user)));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null && widget.images[0] is ImageUploadModel) {
      return StreamBuilder<dynamic>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_uploadTask.isComplete)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.cloud_done,
                        color: Colors.blue,
                      ),
                    ),
                  if (_uploadTask.isInProgress)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CircularProgressIndicator(
                        value: progressPercent,
                        backgroundColor: Colors.blue,
                      ),
                    ),
                ]);
          });
    } else {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: RaisedButton.icon(
          color: Colors.deepPurple,
          label: Text(
            'Upload',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.cloud_upload,
            color: Colors.white,
          ),
          onPressed: _startUpload,
        ),
      );
    }
  }
}
