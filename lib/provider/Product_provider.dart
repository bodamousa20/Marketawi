import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marketawi/auth/register.dart';
import '../pojo/login_pojo.dart';
import '../pojo/product_pojo.dart'; // Import the Product model
import '../pojo/category_pojo.dart';

class ProductProvider with ChangeNotifier {
  String baseUrl = "http://192.168.1.7:8080/api/v1";
  List<Product> products = [];
  Product? product;
  List<Category_items> categories = [];
  bool loading = false;
  String? user_token;
  String? login_message;
  String? userName;
  String? register_message;
  String? message;
  int? userId;
  CartData? _cartData;

  CartData? get cartData => _cartData;

  Future<void> addProductToCart(int userId, int productId) async {
    try {
      final url = Uri.parse("$baseUrl/add-to-cart/$userId/$productId");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json", // Adjust headers if needed
        },
      );
      final decodedJson = json.decode(response.body);

      if (response.statusCode == 200) {
        print("added to cart");
        message = decodedJson['message'];
        notifyListeners();
      } else {
        throw Exception("Failed to load products for category");
      }
    } catch (e) {
      print("Error added product to cart: $e");
    }
  }
  Future<void> deleteFromCart(int userId, int productId) async {
    try {
      final url = Uri.parse("$baseUrl/$userId/delete/$productId");

      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json", // Adjust headers if needed
        },
      );
      final decodedJson = json.decode(response.body);

      if (response.statusCode == 200) {
        print("deleted from cart");
        message = decodedJson['message'];
        notifyListeners();
      } else {
        throw Exception("Failed to delete");
      }
    } catch (e) {
      print("Error added product to cart: $e");
    }
  }
  Future<void> decrease(int userId, int productId) async {
    try {
      final url = Uri.parse("$baseUrl/$userId/decrease/$productId");

      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json", // Adjust headers if needed
        },
      );
      final decodedJson = json.decode(response.body);

      if (response.statusCode == 200) {
        message = decodedJson['message'];
        notifyListeners();
      } else {
        throw Exception("Failed to decresae");
      }
    } catch (e) {
    //  print("Error added product to cart: $e");
    }
  }
  Future<void> increase(int userId, int productId) async {
    try {
      final url = Uri.parse("$baseUrl/$userId/increase/$productId");

      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json", // Adjust headers if needed
        },
      );
      final decodedJson = json.decode(response.body);

      if (response.statusCode == 200) {
        message = decodedJson['message'];
        notifyListeners();
      } else {
        throw Exception("Failed to increae");
      }
    } catch (e) {
     // print("Error added product to cart: $e");
    }
  }
  Future<void> getUserCart(int userId) async {
    try {
      loading = true;
      notifyListeners();

      final url = Uri.parse("$baseUrl/$userId");
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        _cartData = CartResponse.fromJson(decodedJson).data;
      } else {
        throw Exception("Failed to load cart data");
      }
    } catch (e) {
      print("Error fetching cart data: $e");
    } finally {
      loading = false;
      notifyListeners();
    }
  }






  Future<void> fetchProductsByCategoryName(String categoryName) async {
    try {
      final url = Uri.parse(
          "${baseUrl}/product/product-category?categoryName=$categoryName");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json", // Adjust headers if needed
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        products.clear();

        products = (data['data'] as List)
            .map((item) => Product.fromJson(item))
            .toList();

        notifyListeners(); // Update UI
      } else {
        throw Exception("Failed to load products for category");
      }
    } catch (e) {
      print("Error fetching products by category: $e");
    }
  }

  Future<void> fetchProducts() async {
    loading = true;

    final url = Uri.parse("${baseUrl}/product/all-product");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);

        // Extract the list from "data"
        final List<dynamic> productsJson = decodedJson['data'] ?? [];

        // Convert the list to Product objects
        products = productsJson.map((item) => Product.fromJson(item)).toList();
        loading = false;
        notifyListeners();
      } else {
        throw Exception("Failed to load products");
      }
    } catch (error) {
      print("Network Error: $error");
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse("${baseUrl}/category/all"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        ApiResponse apiResponse = ApiResponse.fromJson(jsonData);
        categories = apiResponse.data;
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (error) {
      print("Error fetching categories: $error");
    }

    notifyListeners();
  }

  Future<void> fetchProductById(int id) async {
    loading = true;
    final url = Uri.parse("${baseUrl}/product/${id}");

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      product = Product.fromJson(data['data']);
      loading = false;
      notifyListeners();
    } else {
      throw Exception("Failed to load product");
    }
  }

  Future<void> fetchProductByName(String name) async {
    loading = true;
    final url = Uri.parse("${baseUrl}/product/search-name/${name}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);

        // Extract the list from "data"
        final List<dynamic> productsJson = decodedJson['data'] ?? [];

        // Convert the list to Product objects
        products = productsJson.map((item) => Product.fromJson(item)).toList();
        loading = false;
        notifyListeners();
      } else {
        throw Exception("Failed to load products");
      }
    } catch (error) {
      print("Network Error: $error");
    }
  }

  Future<void> login(String email, String password) async {
    loading = true;
    final url = Uri.parse("http://192.168.1.7:8080/auth/login");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    final decodedJson = json.decode(response.body);
    if (response.statusCode == 200) {
      login_message = decodedJson['message'];
      userName = decodedJson['data']['name'];
      userId = decodedJson['data']['user_id'];
      print(login_message);
      user_token = decodedJson['data']['token'];
      print("Login Successful: ${decodedJson}");
    } else {
      login_message = decodedJson['message'];
      print(login_message);
    }
    loading = false;
    notifyListeners(); // Notify UI update
  }

  Future<void> register(String name, String email, String password,
      String username, String phone) async {
    loading = true;
    final url = Uri.parse("http://192.168.1.7:8080/auth/signup");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "userName": userName,
        "phone": phone
      }),
    );
    final decodedJson = json.decode(response.body);
    if (response.statusCode == 200) {
      register_message = decodedJson["message"];
      print("Login Successful: ${decodedJson}");
    } else {
      login_message = decodedJson['message'];
      print(login_message);
    }
    loading = false;
    notifyListeners(); // Notify UI update
  }
}
