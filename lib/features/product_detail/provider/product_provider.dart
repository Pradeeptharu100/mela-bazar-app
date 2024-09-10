import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:melebazaar_app/features/product_detail/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  final Map<String, int> _selectedIndices = {};
  bool _isLoading = false;
  int _totalQuantity = 0;

  Product? _product;
  ProductProvider() {
    fetchProduct();
  }

  bool get isLoading => _isLoading;

  Product? get product => _product;
  Map<String, int> get selectedIndices => _selectedIndices;

  int get totalQuantity => _totalQuantity;

  Future<void> fetchProduct() async {
    final dio = Dio();
    _isLoading = true;
    notifyListeners();
    try {
      final response = await dio.get(
        'https://api.melabazaar.com.np/api/v1/items/product_list/realme-c30/?format=json',
      );
      if (response.statusCode == 200) {
        // Assuming the 'data' field contains the product details
        Map<String, dynamic> jsonData = response.data['data'];
        _product = Product.fromJson(jsonData);
      } else {}
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  int getSelectedIndex(String variantType) {
    return _selectedIndices[variantType] ?? -1;
  }

  void setSelectedIndex(String variantType, int index) {
    _selectedIndices[variantType] = index;
    notifyListeners();
  }

  void updateQuantity() {
    _totalQuantity++;
    notifyListeners();
  }
}
