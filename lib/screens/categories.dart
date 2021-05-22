import 'package:flutter/material.dart';
import 'package:lost_found_app/screens/sign_out.dart';
import 'package:lost_found_app/screens/uploadPage.dart';
import 'package:lost_found_app/services/upload_service.dart';
import 'package:provider/provider.dart';

/*
This screen shows the available categories to the user and also allows the user
to select a specific category. The selected category will then be uploaded in 
the Firebase for future usecase.
*/

class Categories extends StatelessWidget {
  final List<IconData> _categoryIcons = [
    Icons.smartphone,
    Icons.access_alarm,
    Icons.account_balance_wallet,
    Icons.account_box,
    Icons.add_a_photo,
  ];
  final List<String> _category = [
    "Smartphone",
    "Watch",
    "Wallet",
    "ID Card",
    "Camera"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Choose a Category"),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            _category.length,
            (index) {
              return InkWell(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        _categoryIcons[index],
                        size: 50,
                        color: Colors.black,
                      ),
                      Container(
                        child: Text(
                          _category[index],
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  // Store the selected category in the Service class
                  context.read<UploadService>().setCategory(_category[index]);
                  print(_category[index]);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UploadPage()));
                },
              );
            },
          ),
        ));
  }
}
