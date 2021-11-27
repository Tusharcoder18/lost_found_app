import 'dart:io';

class Report {
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

  // Report(
  //   this._title,
  //   this._category,
  //   this._value,
  //   this._location,
  //   this._date,
  //   this._timeTo,
  //   this._timeFrom,
  //   this._uniqueInfo,
  //   this._anythingElse,
  //   this._imageUrls,
  // );

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

  void setImages(List<File> images) {
    _images = images;
  }

  void setImageUrls(String imageUrl) {
    _imageUrls.add(imageUrl);
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

  List<String> getImageUrls() {
    return _imageUrls;
  }

  // factory Report.fromJson(Map<String, dynamic> json) {
  //   return Report(
  //     json['title'],
  //     json['category'],
  //     json['value'],
  //     json['location'],
  //     json['date'],
  //     json['timeTo'],
  //     json['timeFrom'],
  //     json['uniqueInfo'],
  //     json['anythingElse'],
  //     json['imageUrls'],
  //   );
  // }
}
