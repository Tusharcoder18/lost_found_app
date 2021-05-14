import 'package:flutter/material.dart';

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                Divider(
                  thickness: 5,
                  color: Colors.deepPurple,
                  indent: 30,
                  endIndent: 30,
                ),
                SizedBox(height: 20),
                Text('You may find your Item here\nBolte toh Search Results',
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          color: Colors.black87,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.transparent,
                  child: GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 15,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 0.7),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  // builder: (context) => ItemDetails()
                                  )),
                          child: Container(
                            //container added just to give border between images
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              color: Colors.white,
                            ),
                            child: Image.network(
                              index % 2 == 0
                                  ? 'https://pbs.twimg.com/media/EDkQdzgWwAUY2RO.jpg'
                                  : 'https://i.pinimg.com/originals/ae/12/a5/ae12a513ca6f29f156d220051e7643c1.jpg',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
