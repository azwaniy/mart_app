import 'package:flutter/material.dart';
import 'package:mart_app/auth/login_or_register.dart';
import 'package:mart_app/models/product.dart';
import 'package:mart_app/pages/home_page.dart'; // Ensure you have a HomePage defined
import 'package:mart_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // theme provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

        // product provider
        ChangeNotifierProvider(create: (context) => Product()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          // While waiting for the Future to complete
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            // If the Future is completed and has data, show the appropriate screen
            if (snapshot.data == true) {
              return const HomePage(); // Make sure you have HomePage defined
            } else {
              return LoginOrRegister(onTap: () {});
            }
          }
        },
      ),
    );
  }
}
