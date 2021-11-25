import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lost_found_app/screens/item_detail_fullscreen.dart';

class LostCards extends StatefulWidget {
  const LostCards({Key key}) : super(key: key);

  @override
  _LostCardsState createState() => _LostCardsState();
}

class _LostCardsState extends State<LostCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Similar Items Found'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(id: 1); // each listing will have a product id ...
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  int id;
  ProductCard({Key key, int id}) {
    this.id = id;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => FullScreen(id)));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: 310,
        width: double.maxFinite,
        child: Card(
          elevation: 8,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: CarouselSlider(
                  items: [
                    //TODO: Display Images here from backend
                    Center(
                        child: Text(
                      'Image 1',
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    )),
                    Center(
                        child: Text(
                      'Image 2',
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    )),
                    Center(
                        child: Text(
                      'Image 3',
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    )),
                  ],
                  options: CarouselOptions(),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  'Title here \nEstimated value: Rs.10000\nFound On: Date', //TODO: Data Fetch from backend
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
