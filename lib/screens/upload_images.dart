import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_found_app/Models/User.dart';
import 'package:lost_found_app/Models/image_upload.dart';
import 'package:lost_found_app/screens/userTags.dart';
import 'package:lost_found_app/services/uploader.dart';

class UploadImages extends StatefulWidget {
  final User user;

  const UploadImages({Key key, this.user}) : super(key: key);
  @override
  _UploadImagesState createState() {
    return _UploadImagesState();
  }
}

class _UploadImagesState extends State<UploadImages> {
  List<Object> images = List<Object>();
  PickedFile _imageFile;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    setState(() {
      images.add("Add Image");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Upload Images Here',
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.amber),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ItemTags(widget.user)));
        },
        child: Text(
          'Next',
          style: TextStyle(color: Colors.amber),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: buildGridView(),
          ),
          Uploader(images: images, user: widget.user),
        ],
      ),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1.1,
      scrollDirection: Axis.vertical,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel && images[index] != null) {
          ImageUploadModel uploadModel = images[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Image.file(
                  uploadModel.imageFile,
                  fit: BoxFit.fill,
                  height: double.maxFinite,
                  width: double.maxFinite,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.removeAt(index);
                        if (index == 3) images.add('Add image');
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            height: 500,
            width: 100,
            child: Card(
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // _onAddImageClick(index);
                  _openImagePickerModal(context, index);
                },
              ),
            ),
          );
        }
      }),
    );
  }

  void _openImagePickerModal(BuildContext context, int index) {
    final flatButtonColor = Colors.deepPurple;
    print('Image Picker Modal Called');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 120.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Pick an Image'),
                  onPressed: () {
                    _onAddImageClick(
                        index,
                        ImageSource
                            .gallery); // badme nikal denge until good solution found . Testing ke liye gallery chahiye hoga...
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Camera'),
                  onPressed: () {
                    _onAddImageClick(index, ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  Future _onAddImageClick(int index, ImageSource source) async {
    try {
      _imageFile = await _picker.getImage(source: source);
      getFileImage(index);
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  void getFileImage(int index) async {
    if (_imageFile != null) {
      setState(() {
        ImageUploadModel imageUpload = ImageUploadModel();
        imageUpload.imageFile = _imageFile as File;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
        if (images.length < 4) {
          print('Added dummy to list');
          images.add('Add Image');
        } else {
          print('snackbar called');
          SnackBar snackbar = new SnackBar(
            content: Text('Maximun Limit Reached!'),
            duration: Duration(seconds: 3),
          );
          _scaffoldKey.currentState.showSnackBar(snackbar);
        }
      });
    } else {
      print('No Image selected! or Images length exceeded!');
    }
  }
}
