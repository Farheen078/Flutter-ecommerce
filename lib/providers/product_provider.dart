import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  ProductProvider() {
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    _isLoading = true;
    notifyListeners();
    // Simulate network delay (remove in production)
    await Future.delayed(const Duration(milliseconds: 800));
    _products = [
      // ... your existing product list (copy from your old ProductProvider)
    ];
    _isLoading = false;
    notifyListeners();
  }

  List<Product> getProductsByCategory(String category) {
    if (category == 'All') return _products;
    return _products.where((p) => p.category == category).toList();
  }

  List<Product> searchProducts(String query) {
    if (query.isEmpty) return _products;
    return _products
        .where(
          (p) =>
              p.name.toLowerCase().contains(query.toLowerCase()) ||
              p.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  // ... other methods (getProductById, etc.)
}
