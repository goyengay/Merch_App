import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  //List Item
  final List _shopItems = [
    ["Action Figure", "10.00", "lib/images/action_figure.png", Colors.red],
    ["Topi", "4.00", "lib/images/hat.png", Colors.brown],
    ["Jaket", "25.00", "lib/images/jacket.png", Colors.yellow],
    ["Tumbler", "8.00", "lib/images/tumbler.png", Colors.green],
  ];

  final List _cartItems = [];

  get shopItems => _shopItems;
  get cartItems => _cartItems;

  //Add Item
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  //Remove Item
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  //Get Total Price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
