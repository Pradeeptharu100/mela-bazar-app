import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:melebazaar_app/features/product_detail/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  Product? _product;
  Product? get product => _product;

  Future<void> fetchProduct() async {
    final dio = Dio();
    try {
      final response = await dio.get(
          'https://api.melabazaar.com.np/api/v1/items/product_list/realme-c30/?format=json');
      if (response.statusCode == 200) {
        _product = Product.fromJson(response.data['data']);
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching product: $e');
    }
  }

 
}
