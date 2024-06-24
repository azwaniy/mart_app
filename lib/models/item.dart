class Item {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final ItemCategory category;

  Item({
    required this.name, //cheese burger
    required this.description, // a burger full of cheese
    required this.imagePath, //lib/images/cheese_burger.png
    required this.price, //4.99
    required this.category, //burger
  });
}

// Item categories
enum ItemCategory {
  Food,
  Beverages,
  BeautyCare,
  Others,
}
