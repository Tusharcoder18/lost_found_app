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

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  LatLng convertToLatLng(pos) {
    int ind1, ind2, ind3, ind4, index = 0;
    while (!isNumeric(pos[index])) index++;
    ind1 = index;
    while (isNumeric(pos[index])) index++;
    ind2 = index - 1;
    while (!isNumeric(pos[index])) index++;
    ind3 = index;
    while (isNumeric(pos[index])) index++;
    ind4 = index - 1;

    double lat = double.parse(pos.substring(ind1, ind2));
    double lon = double.parse(pos.substring(ind3, ind4));
    return LatLng(lat, lon);
  }

  CameraPosition getLocation(Report report) {
    var pos = report.getLocation();
    _currentPos = convertToLatLng(pos);
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Result'),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        onPressed: () async {
          launch("tel:+918919650742");
        }, //
        child: Icon(
          Icons.call,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              elevation: 20,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: SizedBox(
                height: screenHeight * 0.4,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CarouselSlider(
                    items: List.generate(_imageUrls.length, (index) {
                      String url = _imageUrls[index];
                      if (url[0] == '[') url = url.substring(1, url.length - 1);
                      return Image.network(url);
                    }),
                    options: CarouselOptions(),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              color: Colors.white,
              child: SizedBox(
                height: screenHeight * 0.1,
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              color: Colors.white,
              child: SizedBox(
                width: screenWidth,
                height: screenHeight * 0.09,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ' Found On ${_date}',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              color: Colors.white,
              child: SizedBox(
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: SizedBox(
                width: screenWidth * 0.95,
                height: screenHeight * 0.25,
                child: GoogleMap(
                  mapType: MapType.terrain,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: _location,
                  onMapCreated: (GoogleMapController controller) async {
                    _controller.complete(controller);
                  },
                  markers: markers,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
