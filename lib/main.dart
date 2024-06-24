import 'package:flutter/material.dart';
import 'package:mart_app/auth/login_or_register.dart';
import 'package:mart_app/models/product.dart';
import 'package:mart_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';
//import 'pages/login_page.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      //theme provider
      ChangeNotifierProvider(create: (context) => ThemeProvider()),

      //product provider
      ChangeNotifierProvider(create: (context) => Product()),
    ],
    child: const MyApp(),
    ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  LoginOrRegister(
        onTap: () {},
        ),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}