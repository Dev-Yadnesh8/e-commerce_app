import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../data/models/product_model.dart';
import 'package:http/http.dart' as http;


class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> _searchedProducts = [];
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String searchText='';

  int _count = 1;

  static const String productUrl = "YOUR-API-KEY";

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
        updateData();
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
  List<ProductModel> get searchedProducts => _searchedProducts;

  // get cart
  List<ProductModel> get cart => _cart;

  // get count
  int get count => _count;

  void incrementCount(ProductModel product) {

    _count++;
    notifyListeners();
  }

  void decrementCount(ProductModel product) {
    if(_count > 1){
      _count--;
    }

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

  void updateData(){
    _searchedProducts.clear();
    if(searchText.isEmpty){
      _searchedProducts.addAll(_products) ;
      print("not searched--$_searchedProducts");
      notifyListeners();
    }else{
      _searchedProducts.addAll(_products.where((element) => element.name!.toUpperCase().startsWith(searchText.toUpperCase())).toList());
      print("searched--$_searchedProducts");
      notifyListeners();
    }

  }

  void search(String value){
    searchText = value;
    updateData();
  }
}
