import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lost_found_app/Models/Report.dart';
import 'package:lost_found_app/screens/item_detail_fullscreen.dart';
import 'package:lost_found_app/services/download_service.dart';
import 'package:provider/src/provider.dart';

class LostCards extends StatefulWidget {
  const LostCards({Key key}) : super(key: key);

  @override
  _LostCardsState createState() => _LostCardsState();
}

class _LostCardsState extends State<LostCards> {
  List<Report> _reports;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> getData() async {
    _reports = await context.read<DownloadService>().fetchData();
    for (int i = 0; i < _reports.length; i++) print(_reports[i].getTitle());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Similar Items Found'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _reports.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                    report: _reports[index],
                    id: 1); // each listing will have a product id ...
              },
            ),
    );
  }
}

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  Report report;
  int id;
  ProductCard({this.report, this.id});

  @override
  Widget build(BuildContext context) {
    String _title = report.getTitle();
    String _value = report.getValue();
    String _date = report.getDate();
    List<String> _imageUrls = report.getImageUrls();

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => FullScreen(id, report)));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: 320,
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
                  items: List.generate(_imageUrls.length, (index) {
                    String url = _imageUrls[index];
                    url = url.substring(1, url.length - 1);
                    return Image.network(url);
                  }),
                  options: CarouselOptions(),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  _title +
                      '\nEstimated value: ' +
                      _value +
                      '\nFound On: ' +
                      _date, //TODO: Data Fetch from backend
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
