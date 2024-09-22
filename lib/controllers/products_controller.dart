import 'package:e_commerce_app/services/product_service.dart';
import 'package:flutter/material.dart';

import '../models/products_model.dart';

class ProductsProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  List<Product> get products => _products;
  bool? displayDiscount = true;


  Future<List<Product>> fetchProducts(BuildContext context) async {
    try {
      _products = await _productService.getProducts();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching products: ${error.toString()}')),
      );
    }
    return _products;
  }

  void updateProductToWishList(String? productId) {
    // products.where((element) => element)
  }
  void updateDiscountDisplayStatus(bool showDiscount) {
    displayDiscount = showDiscount;
    notifyListeners();
  }


}
