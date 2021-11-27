import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lost_found_app/Models/Report.dart';
import 'package:lost_found_app/screens/item_detail_fullscreen.dart';
import 'package:lost_found_app/screens/landing_screen.dart';
import 'package:lost_found_app/widgets/custom_button.dart';
import 'package:provider/src/provider.dart';

class FinalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final String assetName = 'assets/success.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Success Logo',
      color: Colors.white,
      width: screenWidth * 0.5,
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.2,
            ),
            Center(child: svg),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Report Submitted Successfully!",
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(fontSize: 20),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.2,
            ),
            CustomButton(
              text: "View Report",
              color: Colors.white,
              icon: Icon(Icons.book),
              style: TextStyle(color: Colors.black),
              onTap: () {
                Report report = context.read<Report>();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FullScreen(1, report)));
              },
            ),
            SizedBox(
              height: 15,
            ),
            CustomButton(
              text: "HomeScreen",
              color: Colors.white,
              icon: Icon(Icons.home),
              style: TextStyle(color: Colors.black),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LandingScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
