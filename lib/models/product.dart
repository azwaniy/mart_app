import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mart_app/models/cart_item.dart';
import 'item.dart';

class Product extends ChangeNotifier {
  // List of item menu
  final List<Item> _menu = [
    // food
    Item(
      name: "Rice",
      description: "Premium Quality Rice!",
      imagePath: "lib/images/food/rice.jpg",
      price: 30.00,
      category: ItemCategory.Food,
    ),
    Item(
      name: "Chicken",
      description: "Juicy and Tender Fresh Chicken!",
      imagePath: "lib/images/food/chicken.jpg",
      price: 15.00,
      category: ItemCategory.Food,
    ),
    Item(
      name: "Potato",
      description: "Discover the versatile and nutritious potato!",
      imagePath: "lib/images/food/potato.jpg",
      price: 10.00,
      category: ItemCategory.Food,
    ),
    Item(
      name: "Carrot",
      description: "Vibrant orange color and crisp texture in every bite!",
      imagePath: "lib/images/food/carrot.jpg",
      price: 6.00,
      category: ItemCategory.Food,
    ),
    Item(
      name: "Meat",
      description: "Discover the Finest Cuts of Meat!",
      imagePath: "lib/images/food/meat.jpg",
      price: 20.00,
      category: ItemCategory.Food,
    ),
    // beverages
    Item(
      name: "Water",
      description: "Pure and Refreshing Hydration!",
      imagePath: "lib/images/beverages/water.jpg",
      price: 1.50,
      category: ItemCategory.Beverages,
    ),
    Item(
      name: "Soda",
      description: "Fizz and Flavor in Every Sip!",
      imagePath: "lib/images/beverages/soda.jpg",
      price: 2.00,
      category: ItemCategory.Beverages,
    ),
    Item(
      name: "Juice",
      description: "Fresh and Fruity Delights!",
      imagePath: "lib/images/beverages/juice.jpg",
      price: 2.50,
      category: ItemCategory.Beverages,
    ),
    Item(
      name: "Milk",
      description: "Creamy and Nutritious Delight!",
      imagePath: "lib/images/beverages/milk.jpg",
      price: 5.00,
      category: ItemCategory.Beverages,
    ),
    Item(
      name: "Coffee",
      description: "Awaken Your Senses!",
      imagePath: "lib/images/beverages/coffee.jpg",
      price: 4.00,
      category: ItemCategory.Beverages,
    ),
    // beauty and personal cares
    Item(
      name: "Body Wash",
      description: "Delightful fragrance that lingers long!",
      imagePath: "lib/images/b&pc/body_wash1.jpg",
      price: 9.00,
      category: ItemCategory.BeautyCare,
    ),
    Item(
      name: "Deodorant",
      description: "Perfect blend of protection and fragrance!",
      imagePath: "lib/images/b&pc/deodorant.jpg",
      price: 4.50,
      category: ItemCategory.BeautyCare,
    ),
    Item(
      name: "Shampoo",
      description: "Experience the refreshing and revitalizing power!",
      imagePath: "lib/images/b&pc/shampoo.jpg",
      price: 8.00,
      category: ItemCategory.BeautyCare,
    ),
    Item(
      name: "Perfume",
      description: "Indulge in a scent that defines you!",
      imagePath: "lib/images/b&pc/perfume.jpg",
      price: 11.00,
      category: ItemCategory.BeautyCare,
    ),
    Item(
      name: "Face Powder",
      description: "Achieve a flawless finish!",
      imagePath: "lib/images/b&pc/face_powder.jpg",
      price: 6.00,
      category: ItemCategory.BeautyCare,
    ),
    // others
    Item(
      name: "Nugget",
      description: "Enjoy the crispy, golden goodness of our nuggets!",
      imagePath: "lib/images/others/nugget.jpg",
      price: 12.00,
      category: ItemCategory.Others,
    ),
    Item(
      name: "Sauce",
      description: "Perfect for enhancing any dish and turning everyday meals into gourmet experiences!",
      imagePath: "lib/images/others/sauce.jpg",
      price: 5.00,
      category: ItemCategory.Others,
    ),
    Item(
      name: "Spices",
      description: "Explore the world of flavors with every pinch!",
      imagePath: "lib/images/others/spices.jpg",
      price: 3.90,
      category: ItemCategory.Others,
    ),
    Item(
      name: "Snack",
      description: "Satisfy your cravings with our irresistible snacks!",
      imagePath: "lib/images/others/snack.jpg",
      price: 3.00,
      category: ItemCategory.Others,
    ),
    Item(
      name: "Biscuits",
      description: "Indulge in the delightful crunch & enjoy the smiles in every bite!",
      imagePath: "lib/images/others/biscuit.jpg",
      price: 5.50,
      category: ItemCategory.Others,
    ),
  ];

  // Getters
  List<Item> get getMenu => _menu;
  List<CartItem> get cart => _cart;

  //user cart
  final List<CartItem> _cart = [];

  //add to cart
  void addToCart(Item item) {
    //see if there is a cart item already with the same product
    CartItem? cartItem = _cart.firstWhere(
      (element) => element.item == item,
      orElse: () => CartItem(item: item, quantity: 0),
    );

    //if item already exists, increase its quantity
    if (cartItem.quantity > 0) {
      cartItem.quantity += 1;
    }

    //otherwise, add a new cart item to the cart
    else {
      _cart.add(CartItem(
        item: item,
        quantity: 1,
      ));
    }
    notifyListeners();
  }

  //remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }

    notifyListeners();
  }

  //get total price of cart
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.item.price;

      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  //get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  //clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  //generate a receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt..");
    receipt.writeln();

    //format the date to include up to seconds only
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("----------");

    for (final cartItem in _cart) {
      receipt.writeln(
        "${cartItem.quantity} x ${cartItem.item.name} - ${_formatPrice(cartItem.item.price)}");

        receipt.writeln();
    }
    receipt.writeln("---------");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");

    return receipt.toString();
  }

  //format double value into money
  String _formatPrice(double price) {
    return "\$${price.toStringAsFixed(2)}";
  }
}
