import 'package:flutter/material.dart';
import 'package:lost_found_app/Lost_screens/lost_details_screen.dart';
import 'package:lost_found_app/Models/Report.dart';
import 'package:lost_found_app/Models/Status.dart';
import 'package:lost_found_app/Models/search.dart';
import 'package:lost_found_app/screens/more_details_screen.dart';
import 'package:lost_found_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

/*
The LocationScreen allows the user to select the location using a Google Maps 
integration and also allows to select the time range between which the valuable 
was lost or found.
*/

class LostLocationScreen extends StatefulWidget {
  @override
  _LostLocationScreenState createState() => _LostLocationScreenState();
}

class _LostLocationScreenState extends State<LostLocationScreen> {
  String _fromTime = "FROM";
  String _toTime = "TO";
  String _location = "INDIA";

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
            child: Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  "Google Maps",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 14),
                ),
              ),
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
          Expanded(child: SizedBox()),
          CustomButton(
            onTap: () {
              // final status = context.read<Status>().getStatus();
              // if(status=="FOUND"){
              context.read<Search>().setTimeFrom(_fromTime);
              context.read<Search>().setTimeTo(_toTime);
              context.read<Search>().setLocation(_location);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LostDetailsScreen()));
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
