import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../data/models/product_model.dart';
import 'package:http/http.dart' as http;


class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  int _count = 0;

  static const String productUrl = "https://664323fd3c01a059ea21a799.mockapi.io/cricket";

  // get products from API
  Future<void> getProduct() async {
    try {
      var res = await http.get(Uri.parse(productUrl));
      if(res.statusCode == 200){
       // print("res--${res.body}");
        List<dynamic> jsonList = jsonDecode(res.body);
        _products = jsonList.map((json) => ProductModel.fromJson(json)).toList();
        _isLoading = false;
        print("List--$_products");
        notifyListeners();
      }else{
        _isLoading = false;
        notifyListeners();
        throw Exception("Error while fetching products");
      }
    } catch (error) {
      _isLoading = false; // Ensure loading is set to false on error
      notifyListeners();
      rethrow;
    }
  }

  // user cart
  List<ProductModel> _cart = [];

  // get products
  List<ProductModel> get products => _products;

  // get cart
  List<ProductModel> get cart => _cart;

  // get count
  int get count => _count;

  void incrementCount() {
    _count++;
    notifyListeners();
  }

  void decrementCount() {
    _count--;
    notifyListeners();
  }

  // add item to cart
  void addItem(ProductModel item) {
    cart.add(item);
    notifyListeners();
  }

  // remove item from cart
  void removeItem(ProductModel item) {
    cart.remove(item);
    notifyListeners();
  }
}
