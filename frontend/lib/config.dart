import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

class Config {
  static String get apiURL {
    if (kIsWeb) {
      // No navegador, use localhost
      return "localhost:4000";
    } else if (Platform.isAndroid) {
      // Em emulador Android, localhost da máquina é 10.0.2.2
      return "10.0.2.2:4000";
    } else {
      // Para iOS ou outros
      return "localhost:4000";
    }
  }

  static const String appName = "In-app purchases";
  static const String imageURL = "http://localhost:4000";
  static const String categoryAPI = "api/category";
  static const String productAPI = "api/product";
  static const String registerAPI = "api/register";
  static const String loginAPI = "api/login";
  static const String sliderAPI = "api/slider";
  static const int pageSize = 10;
  static const String currency = "MT ";
}
