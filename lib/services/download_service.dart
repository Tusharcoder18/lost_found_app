import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lost_found_app/Models/Report.dart';
import 'package:lost_found_app/Models/Search.dart';

class DownloadService {
  final FirebaseFirestore _firestoreReference = FirebaseFirestore.instance;

<<<<<<< HEAD
  // ignore: missing_return
  Future<List<Report>> fetchData() async {
=======
  Future<List<Report>> fetchData(Search search) async {
>>>>>>> fbc4bb324363898261748729d948f4a0d81f3cdc
    try {
      List<Report> _reports = [];
      CollectionReference reportsReference =
          _firestoreReference.collection("reports");

      QuerySnapshot snapshot = await reportsReference.get();
      List<DocumentSnapshot> reports = snapshot.docs;
      String _title = search.getTitle();

      for (int i = 0; i < reports.length; i++) {
        // Report report = Report.fromJson(reports[i].data());
        var data = reports[i].data() as Map;

        if (data['title']
            .toString()
            .toLowerCase()
            .startsWith(_title.toLowerCase())) {
          Report report = Report();
          report.setTitle(data['title'].toString());
          report.setCategory(data['category'].toString());
          report.setValue(data['value'].toString());
          report.setLocation(data['location'].toString());
          report.setDate(data['date'].toString());
          report.setTimeTo(data['timeTo'].toString());
          report.setTimeFrom(data['timeFrom'].toString());
          report.setUniqueInfo(data['uniqueInfo'].toString());
          report.setAnythingElse(data['anythingElse'].toString());
          report.setImageUrls(data['imageUrls'].toString());

          _reports.add(report);
        }
      }

      return _reports;
    } catch (e) {
      print(e);
    }
  }
}
