//import 'package:flutter/material.dart';
import 'package:mart_app/models/item.dart';

class CartItem{
  Item item;
  int quantity;

  CartItem({
    required this.item,
    this.quantity = 1,
  });

  double get totalPrice {
    return (item.price * quantity);
  }

}