import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/mock_data.dart';
import '../core/supabase_service.dart';

class ShopProvider with ChangeNotifier {
  List<Product> _products = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _isLoading = false;

  ShopProvider() {
    fetchProducts();
  }

  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    // We defer notifyListeners to avoid build phase conflicts during initialization
    Future.microtask(() => notifyListeners());

    final client = SupabaseService.client;
    if (client != null) {
      try {
        final data = await client.from('products').select();
        _products = (data as List<dynamic>).map((item) => Product(
          id: item['id'].toString(),
          name: item['name'].toString(),
          price: double.parse(item['price'].toString()),
          imagePath: item['image_path'].toString(),
          category: item['category'].toString(),
          description: item['description'].toString(),
        )).toList();
      } catch (e) {
        debugPrint('Failed to load live products, falling back to mock: $e');
        _products = mockProducts;
      }
    } else {
      _products = mockProducts;
    }

    _isLoading = false;
    notifyListeners();
  }


  List<Product> get products {
    return _products.where((product) {
      final matchesCategory = _selectedCategory == 'All' || product.category == _selectedCategory;
      final matchesSearch = product.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
