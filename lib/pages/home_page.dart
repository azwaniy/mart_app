import 'package:flutter/material.dart';
import 'package:mart_app/components/my_current_location.dart';
import 'package:mart_app/components/my_description_box.dart';
import 'package:mart_app/components/my_drawer.dart';
import 'package:mart_app/components/my_item_tile.dart';
import 'package:mart_app/components/my_sliver_app_bar.dart';
import 'package:mart_app/components/my_tab_bar.dart';
import 'package:mart_app/models/item.dart';
import 'package:mart_app/models/product.dart';
import 'package:mart_app/pages/item_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  // Tab controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: ItemCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Sort out and return a list of product items that belong to a specific category
  List<Item> _filterMenuByCategory(ItemCategory category, List<Item> fullMenu) {
    return fullMenu.where((item) => item.category == category).toList();
  }

  // Return list of items in given category
  List<Widget> getItemInThisCategory(List<Item> fullMenu) {
    return ItemCategory.values.map((category) {
      // Get category menu
      List<Item> categoryMenu = _filterMenuByCategory(category, fullMenu);

      return SingleChildScrollView(
        child: Column(
          children: List.generate(categoryMenu.length, (index) {
            // Get individual item
            final item = categoryMenu[index];

            // Return item tile UI
            return ItemTile(
              item: item,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemPage(item: item),
                ),
              ),
            );
          }),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
            title: MyTabBar(tabController: _tabController),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),

                // Current location switch
                const MyCurrentLocation(),

                // Description box
                const MyDescriptionBox(),
              ],
            ),
          ),
        ],
        body: Consumer<Product>(
          builder: (context, product, child) => TabBarView(
            controller: _tabController,
            children: getItemInThisCategory(product.getMenu),
          ),
        ),
      ),
    );
  }
}
