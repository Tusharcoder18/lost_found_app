import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lost_found_app/Models/Report.dart';

class DownloadService {
  final FirebaseFirestore _firestoreReference = FirebaseFirestore.instance;

  Future<List<Report>> fetchData() async {
    try {
      List<Report> _reports = [];
      CollectionReference reportsReference =
          _firestoreReference.collection("reports");

      QuerySnapshot snapshot = await reportsReference.get();
      List<DocumentSnapshot> reports = snapshot.docs;

      for (int i = 0; i < reports.length; i++) {
        // Report report = Report.fromJson(reports[i].data());
        var data = reports[i].data() as Map;
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

      return _reports;
    } catch (e) {
      print(e);
    }
  }
}