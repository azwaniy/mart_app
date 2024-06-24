import 'package:flutter/material.dart';
import 'package:mart_app/components/my_button.dart';
import 'package:mart_app/models/item.dart';
import 'package:mart_app/models/product.dart';
import 'package:provider/provider.dart';

class ItemPage extends StatefulWidget {
  final Item item;

  const ItemPage({
    super.key,
    required this.item,
  });

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {

  //method add to cart
  void addToCart(Item item) {

    //close the current item page to go back to menu
    Navigator.pop(context);

    //add to cart
    context.read<Product>().addToCart(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  // Ensuring Scaffold provides the Material context
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // item image
                Image.asset(widget.item.imagePath),

                // item name
                Text(
                  widget.item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                // item price
                Text(
                  'RM${widget.item.price}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                // item description
                Text(widget.item.description),

                const SizedBox(height: 10),

                Divider(color: Theme.of(context).colorScheme.secondary),

                const SizedBox(height: 10),

                // button -> add to cart
                Consumer<Product>(
                  builder: (context, product, child) {
                    return MyButton(
                      onTap: () {
                        product.addToCart(widget.item);
                      },
                      text: "Add to cart",
                    );
                  },
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),

          // back button
          SafeArea(
            child: Opacity(
              opacity: 0.6,
              child: Container(
                margin: const EdgeInsets.only(left: 25),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
