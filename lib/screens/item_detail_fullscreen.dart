import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lost_found_app/Models/Report.dart';
import 'package:url_launcher/url_launcher.dart';

class FullScreen extends StatefulWidget {
  int itemid;
  Report report;

  FullScreen(int id, Report report) {
    this.itemid = id;
    this.report = report;
  }

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng _currentPos;

  CameraPosition getLocation(Report report) {
    var pos = report.getLocation();
    double lat = double.parse(pos.substring(7, 23));
    double lon = double.parse(pos.substring(25, 41));
    _currentPos = LatLng(lat, lon);
    final CameraPosition _location = CameraPosition(
      target: _currentPos,
      zoom: 14.4746,
    );

    return _location;
  }

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    Report _report = widget.report;
    List<String> _imageUrls = _report.getImageUrls();
    String _title = _report.getTitle();
    String _date = _report.getDate();
    String _uniqueInfo = _report.getUniqueInfo();
    CameraPosition _location = getLocation(_report);
    Set<Marker> markers = Set.from([]);
    markers.add(Marker(
        markerId: MarkerId('1'),
        icon: BitmapDescriptor.defaultMarker,
        position: _currentPos,
        onTap: () {}));

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CarouselSlider(
                  items: List.generate(_imageUrls.length, (index) {
                    String url = _imageUrls[index];
                    url = url.substring(1, url.length - 1);
                    return Image.network(url);
                  }),
                  options: CarouselOptions(),
                ),
                // CarouselSlider(
                //   options: CarouselOptions(),
                //   items: list
                //       .map((item) => Container(
                //             child: Center(
                //                 //TODO: Display Image from backend here
                //                 child: Text(
                //               item.toString(),
                //               style:
                //                   TextStyle(color: Colors.black, fontSize: 30),
                //             )),
                //           ))
                //       .toList(),
                // ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              color: Colors.white,
              width: screenWidth,
              child: Text(
                _title, //TODO: Add Title Here from backend
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              color: Colors.white,
              width: screenWidth,
              child: Text(
                '\nFound On ${_date}\n', //TODO: Add Found Date Here from backend
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black),
              ),
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
                      text: _uniqueInfo,
                      style: TextStyle(
                          fontSize: 15, letterSpacing: 1, color: Colors.black),
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
                    _location, //TODO: Add location from backend
                onMapCreated: (GoogleMapController controller) async {
                  _controller.complete(controller);
                },
                markers: markers, //TODO: Add marker to the found Location
              ),
            ),
          ],
        ),
      ),
    );
  }
}
