import 'dart:convert';

import 'package:e_commerce_app/models/products_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<Product>> getProducts() async {
    List<Product> productList = [];

    String url = "https://dummyjson.com/products";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var products = jsonResponse['products'];
      for (int i = 0; i < products.length; i++) {
        productList.add(Product.fromJson(products[i]));
      }
    } else {
      throw Exception("Failed to load products");
    }
    return productList;
  }
}
