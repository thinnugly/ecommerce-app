// utils/shared_service.dart
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SharedService {
  static final Box userBox = Hive.box('userBox');

  static Future<bool> isLoggedIn() async {
    final token = getToken();
    return token != null && !JwtDecoder.isExpired(token);
  }

  static Future<void> setLoginDetails(Map<String, dynamic> userData) async {
    await userBox.put('token', userData['token']);
    await userBox.put('email', userData['email']);
    await userBox.put('fullName', userData['fullName']);
    await userBox.put('userId', userData['userId']);
  }

  static String? getToken() => userBox.get('token');

  static String? getNome() => userBox.get('fullName');

  static bool isTokenExpired() {
    final token = getToken();
    return token == null || JwtDecoder.isExpired(token);
  }

  static Future<void> logout() async {
    await userBox.clear();
  }

  static Map<String, dynamic> loginDetails() {
    return {
      'token': getToken(),
      'email': userBox.get('email'),
      'fullName': getNome(),
      'userId': userBox.get('userId'),
    };
  }
}

