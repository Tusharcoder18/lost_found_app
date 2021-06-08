import 'dart:io';
import 'dart:js';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lost_found_app/services/upload_service.dart';
import 'package:provider/provider.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  List<File> _images = [];
  @override
  Widget build(BuildContext context) {
    final screemHeight = MediaQuery.of(context).size.height;
    _images = context.read<UploadService>().getImages();
    return Scaffold(
      appBar: AppBar(
        title: Text("Final Preview!"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: screemHeight * 0.3,
            child: CarouselSlider(
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
              ),
              items: List.generate(_images.length, (index) {
                return Image.file(
                  _images[index],
                  fit: BoxFit.cover,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
