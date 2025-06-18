import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config.dart';
import 'package:frontend/models/cart.dart';
import 'package:frontend/models/order_model.dart';
import 'package:frontend/models/paypal_order_response.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/product_filter.dart';
import 'package:frontend/models/slider.dart';
import 'package:frontend/utils/shared_service.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/models/category.dart';
import 'package:logger/logger.dart';

final apiService = Provider((ref) => APIService());
final logger = Logger();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class APIService {
  static var client = http.Client();

  Future<List<Category>?> getCategories(page, pageSize) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };

    var url = Uri.http(Config.apiURL, Config.categoryAPI, queryString);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return categoriesFromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<List<Product>?> getProducts(
    ProductFilterModel productFilterModel,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': productFilterModel.paginationModel.page.toString(),
      'pageSize': productFilterModel.paginationModel.pageSize.toString(),
    };

    if (productFilterModel.categoryId != null) {
      queryString["categoryId"] = productFilterModel.categoryId!;
    }

    if (productFilterModel.sortBy != null) {
      queryString["sort"] = productFilterModel.sortBy!;
    }

    if (productFilterModel.productIds != null) {
      queryString["productIds"] = productFilterModel.productIds!.join(",");
    }

    var url = Uri.http(Config.apiURL, Config.productAPI, queryString);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      log(response.body, name: 'APIService.getProducts');
      var data = jsonDecode(response.body);
      return productsFromJson(data["data"]);
    } else {
      return null;
    }
  }

  static Future<bool> registerUser(
    String fullName,
    String email,
    String password,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "fullName": fullName,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<Map<String, dynamic>?> loginUser(
    String email,
    String password,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.loginAPI);

    try {
      var response = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

        if (responseBody['message'] == 'Success' &&
            responseBody['data'] != null) {
          final userData = responseBody['data'] as Map<String, dynamic>;
          return userData;
        } else {
          logger.i('Resposta inesperada: $responseBody');
          return null;
        }
      }
      return null;
    } on SocketException {
      // Erro de conexão
      throw Exception("Não foi possível conectar ao servidor.");
    } catch (e) {
      logger.e("Erro inesperado: $e");
      return null;
    }
  }

  Future<List<SliderModel>?> getSliders(page, pageSize) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };

    var url = Uri.http(Config.apiURL, Config.sliderAPI, queryString);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // logger.i('APIResponse: $data');
      return slidersFromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<Product?> getProductsDetails(String productId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, "${Config.productAPI}/$productId");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Product.fromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<Cart?> getCart() async {
    var loginDetails = SharedService.loginDetails();
    String? token = loginDetails['token'];

    if (token == null) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
      return null;
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.http(Config.apiURL, Config.cartAPI);
    var response = await client.get(url, headers: requestHeaders);

    // Logar o código de status da resposta e o corpo da resposta
    logger.i("Status Code: ${response.statusCode}");
    logger.i("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["data"] != null) {
        return Cart.fromJson(data["data"]);
      } else {
        return Cart(products: [], userId: '', cartId: '');
      }
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
      return null;
    } else {
      return null;
    }
  }

  Future<bool?> addCartItem(productId, qty) async {
    var loginDetails = SharedService.loginDetails();
    String? token = loginDetails['token'];

    if (token == null) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
      return null;
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.http(Config.apiURL, Config.cartAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "products": [
          {"product": productId, "qty": qty},
        ],
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
      return null;
    } else {
      return null;
    }
  }

  Future<bool?> removeCartItem(productId, qty) async {
    final loginDetails = SharedService.loginDetails();
    String? token = loginDetails['token'];

    if (token == null) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
      return null;
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final url = Uri.http(Config.apiURL, Config.cartAPI);

    try {
      final response = await client.delete(
        url,
        headers: requestHeaders,
        body: jsonEncode({"productId": productId, "qty": qty}),
      );

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          "/login",
          (route) => false,
        );
        return null;
      } else {
        return false;
      }
    } catch (e, s) {
      logger.e("Erro durante a requisição DELETE", error: e, stackTrace: s);
      return false;
    }
  }

  Future<OrderModel?> createOrder() async {
    var loginDetails = SharedService.loginDetails();
    String? token = loginDetails['token'];

    if (token == null) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
      return null;
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.http(Config.apiURL, Config.orderAPI);
    var response = await client.post(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["data"] != null) {
        return OrderModel.fromJson(data["data"]);
      }
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
      return null;
    }

    return null;
  }

  Future<PaypalOrderResponse?> createPaypalOrder(String orderId) async {
    var loginDetails = SharedService.loginDetails();
    String? token = loginDetails['token'];

    if (token == null) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
      return null;
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.http(Config.apiURL, "${Config.createPayPalAPI}/$orderId");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({'orderId': orderId}),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      logger.i("🧾 Resposta JSON: $data");
      return PaypalOrderResponse.fromJson(data);
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
      return null;
    }

    return null;
  }

  Future<String?> getPaymentStatus(String orderId) async {
    var loginDetails = SharedService.loginDetails();
    String? token = loginDetails['token'];

    if (token == null) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
      return null;
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.http(Config.apiURL, Config.orderAPI, {'orderId': orderId});

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['paymentStatus']; // <- correto aqui
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
      return null;
    }

    return null;
  }

  Future<bool?> clearCartByUserId() async {
    final loginDetails = SharedService.loginDetails();
    String? token = loginDetails['token'];

    if (token == null) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
      return null;
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final url = Uri.http(Config.apiURL, "${Config.cartAPI}/clear");

    try {
      final response = await client.delete(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          "/login",
          (route) => false,
        );
        return null;
      } else {
        return false;
      }
    } catch (e, s) {
      logger.e("Erro durante a requisição DELETE", error: e, stackTrace: s);
      return false;
    }
  }
}
