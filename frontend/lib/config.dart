import 'dart:io';

class Config {
  static String get apiURL {
    if (Platform.isAndroid) {
      return "10.0.2.2:4000";
    } else {
      return "localhost:4000";
    }
  }

  static const String imageURL = "http://localhost:4000";
  static const String categoryAPI = "api/category";
  static const int pageSize = 10;
}
