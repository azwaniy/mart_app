import 'package:flutter/material.dart';
import 'package:mart_app/components/my_quantity_selector.dart';
import 'package:mart_app/models/cart_item.dart';
import 'package:mart_app/models/product.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;

  const MyCartTile({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(
      builder: (context, product, child) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Material(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //food image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        cartItem.item.imagePath,
                        height: 100,
                        width: 100,
                      ),
                    ),

                    const SizedBox(width: 10),

                    //name and price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //food name
                        Text(cartItem.item.name),

                        //food price
                        Text(
                          'RM${cartItem.item.price}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    //increment or decrement quantity
                    QuantitySelector(
                      quantity: cartItem.quantity,
                      item: cartItem.item,
                      onDecrement: () {
                        product.removeFromCart(cartItem);
                      },
                      onIncrement: () {
                        product.addToCart(cartItem.item);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
