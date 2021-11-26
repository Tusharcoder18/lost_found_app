import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lost_found_app/Models/Report.dart';
import 'package:lost_found_app/screens/more_details_screen.dart';
import 'package:lost_found_app/widgets/custom_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart' as LocationManager;

/*
The LocationScreen allows the user to select the location using a Google Maps 
integration and also allows to select the time range between which the valuable 
was lost or found.
*/

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _fromTime = "FROM";
  String _toTime = "TO";
  String _location = "INDIA";
  DateTime selectedDate = DateTime.now();
  String _date;
  LatLng currentLocation;
  Set<Marker> markers;

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    markers = Set.from([]);
  }

  // Returns the current time in the format "hour:minute Period"
  String getCurrentTime() {
    TimeOfDay now = TimeOfDay.now();
    String hour = (now.hour.toString().length == 1)
        ? '0' + now.hour.toString()
        : now.hour.toString();
    String minute = (now.minute.toString().length == 1)
        ? '0' + now.minute.toString()
        : now.minute.toString();
    return hour +
        ':' +
        minute +
        ' ' +
        ((now.period == DayPeriod.am) ? 'AM' : 'PM');
  }

  // Shows a dialog containing a material design time picker and returns the
  // selected time as a Future
  Future<String> _selectTime(BuildContext context) async {
    String time = "TIME";
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        String hour = (picked.hour.toString().length == 1)
            ? '0' + picked.hour.toString()
            : picked.hour.toString();
        String minute = (picked.minute.toString().length == 1)
            ? '0' + picked.minute.toString()
            : picked.minute.toString();
        time = hour +
            ' : ' +
            minute +
            ' ' +
            ((picked.period == DayPeriod.am) ? 'AM' : 'PM');
      });
    else
      time = getCurrentTime();
    return time;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _date = selectedDate.toString().substring(0, 10);
      });
  }

  Future<LatLng> getUserLocation() async {
    LocationManager.LocationData currentLocation;

    final location = LocationManager.Location();

    try {
      currentLocation = await location.getLocation();

      final lat = currentLocation.latitude;

      final lng = currentLocation.longitude;

      final center = LatLng(lat, lng);

      return center;
    } on Exception {
      currentLocation = null;

      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Location and Time"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Google Maps
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.5,
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);
                currentLocation = await getUserLocation();
              },
              markers: markers,
              onTap: (pos) {
                print(pos);
                _location = pos.toString();
                // pos is the location in LatLng which needs to be saved in the backend.
                Marker f = Marker(
                    markerId: MarkerId('1'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: pos,
                    onTap: () {});

                setState(() {
                  markers.add(f);
                });
              },
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Please enter the time range you found the valuable:",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // From button
              MaterialButton(
                onPressed: () async {
                  _fromTime = await _selectTime(context);
                  setState(() {});
                },
                height: screenHeight * 0.07,
                color: Colors.white,
                child: Text(
                  _fromTime,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Text("--"),
              // To button
              MaterialButton(
                onPressed: () async {
                  _toTime = await _selectTime(context);
                  setState(() {});
                },
                height: screenHeight * 0.07,
                color: Colors.white,
                child: Text(
                  _toTime,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Please enter the date you found the valuable:",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 15),
          CustomButton(
            onTap: () => _selectDate(context),
            color: Colors.white,
            text: _date ?? "Select Date",
            style: TextStyle(color: Colors.black),
            icon: Icon(Icons.date_range),
          ),
          Expanded(child: SizedBox()),
          CustomButton(
            onTap: () {
              // final status = context.read<Status>().getStatus();
              // if(status=="FOUND"){
              context.read<Report>().setTimeFrom(_fromTime);
              context.read<Report>().setTimeTo(_toTime);
              context.read<Report>().setLocation(_location);
              context.read<Report>().setDate(_date);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MoreDetailsScreen()));
              //           }  else {
              //             context.read<Search>().setTimeFrom(_fromTime);
              // context.read<Search>().setTimeTo(_toTime);
              // context.read<Search>().setLocation(_location);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => LostDetailsScreen()));
              //           }
            },
            color: Colors.white,
            text: "Next",
            style: TextStyle(color: Colors.black),
            icon: Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}
