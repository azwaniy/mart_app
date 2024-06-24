import 'package:flutter/material.dart';
import 'package:mart_app/models/item.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final Item item;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.item,
    required this.onDecrement,
    required this.onIncrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onDecrement,
          icon: const Icon(Icons.remove),
        ),
        Text(quantity.toString()),
        IconButton(
          onPressed: onIncrement,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
