import 'dart:io';

class Search {
  String _title;
  String _category;
  String _value;
  String _location;
  String _date;
  String _timeTo;
  String _timeFrom;
  String _uniqueInfo;
  String _anythingElse;
  List<String> _imageUrls = [];
  List<File> _images = [];

  void setTitle(String title) {
    _title = title;
  }

  void setCategory(String category) {
    _category = category;
  }

  void setValue(String value) {
    _value = value;
  }

  void setLocation(String location) {
    _location = location;
  }

  void setDate(String date) {
    _date = date;
  }

  void setTimeTo(String timeTo) {
    _timeTo = timeTo;
  }

  void setTimeFrom(String timeFrom) {
    _timeFrom = timeFrom;
  }

  void setUniqueInfo(String uniqueInfo) {
    _uniqueInfo = uniqueInfo;
  }

  void setAnythingElse(String anythingElse) {
    _anythingElse = anythingElse;
  }

  void setImages(File image) {
    _images.add(image);
  }

  String getTitle() {
    return _title;
  }

  String getCategory() {
    return _category;
  }

  String getValue() {
    return _value;
  }

  String getLocation() {
    return _location;
  }

  String getDate() {
    return _date;
  }

  String getTimeTo() {
    return _timeTo;
  }

  String getAnythingElse() {
    return _anythingElse;
  }

  String getTimeFrom() {
    return _timeFrom;
  }

  String getUniqueInfo() {
    return _uniqueInfo;
  }

  List<File> getImages() {
    return _images;
  }
}
