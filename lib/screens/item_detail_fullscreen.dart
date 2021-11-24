import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FullScreen extends StatefulWidget {
  int itemid;

  FullScreen(int id) {
    this.itemid = id;
  }

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          launch("tel:+918919650742"); //TODO: Add Uploaders number from backend
        }, //
        child: Icon(
          Icons.call,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CarouselSlider(
                    options: CarouselOptions(),
                    items: list
                        .map((item) => Container(
                              child: Center(
                                  //TODO: Display Image from backend here
                                  child: Text(
                                item.toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 30),
                              )),
                            ))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black,width: 2),

                  color: Colors.white,
                ),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Description:\n\n',
                        style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      TextSpan(
                        text:
                            ' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quis ipsum neque. Curabitur malesuada molestie quam, vitae suscipit dui eleifend in. Nam dapibus turpis at venenatis accumsan. Nullam ornare lorem nec ullamcorper elementum. Ut molestie quam dolor, sit amet maximus sapien scelerisque id. Donec vel mauris at lacus finibus ornare et in felis. Aliquam erat volutpat. Morbi eu nunc felis. Quisque et enim non ex euismod rutrum non quis erat. Aenean scelerisque massa ac ante aliquam, et congue erat blandit. Nullam neque sapien, dapibus et interdum eget, venenatis id felis. Maecenas id iaculis velit. Suspendisse pharetra urna justo, a sagittis lorem laoreet vel.',
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 1,
                            color: Colors.black),
                      )
                    ],
                    style: TextStyle(
                        // fontSize: 15,
                        ),
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.95,
                height: screenHeight * 0.25,
                child: GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition:
                      _kGooglePlex, //TODO: Add location from backend
                  onMapCreated: (GoogleMapController controller) async {
                    _controller.complete(controller);
                  },
                  // markers: markers, //TODO: Add marker to the found Location
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
