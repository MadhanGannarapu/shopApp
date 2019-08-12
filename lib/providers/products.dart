import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './product.dart';
import '../widgets/badge.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Watch',
      description: 'Fastrack watch',
      price: 3800,
      imageUrl:
          'https://staticimg.titan.co.in/Fastrack/Catalog/3147KM01_1.jpg?pView=pdp',
    ),
    Product(
      id: 'p2',
      title: 'Shoe',
      description: 'Fastrack watch',
      price: 3800,
      imageUrl:
          'https://staticimg.titan.co.in/Fastrack/Catalog/3147KM01_1.jpg?pView=pdp',
    ),
    Product(
      id: 'p3',
      title: 'Shirt',
      description: 'Fastrack watch',
      price: 3800,
      imageUrl:
          'https://staticimg.titan.co.in/Fastrack/Catalog/3147KM01_1.jpg?pView=pdp',
    ),
    Product(
      id: 'p4',
      title: 'Phone',
      description: 'Fastrack watch',
      price: 3800,
      imageUrl:
          'https://staticimg.titan.co.in/Fastrack/Catalog/3147KM01_1.jpg?pView=pdp',
    )
  ];
  // List<Product> get items {
  //   return [..._items];
  // }

  var _showFavouritesOny = false;

  List<Product> get items {
    // if (_showFavouritesOny) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavouritesOnly() {
  //   _showFavouritesOny = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavouritesOny = false;
  //   notifyListeners();
  // }

  Future<void> addProduct(Product product) async {
    const url = 'https://flutter-crud-e341b.firebaseio.com/products.json';
    print(url);
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavourite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {}
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
