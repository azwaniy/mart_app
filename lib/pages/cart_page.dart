import 'package:flutter/material.dart';
import 'package:mart_app/components/my_cart_tile.dart';
import 'package:mart_app/models/product.dart';
import 'package:provider/provider.dart';
import 'package:mart_app/components/my_button.dart';
import 'package:mart_app/pages/payment_page.dart'; // Make sure to import PaymentPage

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(
      builder: (context, product, child) {
        // Cart
        final userCart = product.cart;

        // Scaffold UI
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              // Clear cart button
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Are you sure you want to clear the cart?"),
                      actions: [
                        // Cancel button
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        // Yes button
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            product.clearCart();
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // List of cart
              Expanded(
                child: userCart.isEmpty
                    ? const Center(
                        child: Text("Cart is empty..."),
                      )
                    : ListView.builder(
                        itemCount: userCart.length,
                        itemBuilder: (context, index) {
                          final cartItem = userCart[index];

                          // Return cart tile UI
                          return MyCartTile(cartItem: cartItem);
                        },
                      ),
              ),
              // Button to pay
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PaymentPage()),
                    );
                  },
                  text: "Go to checkout",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
