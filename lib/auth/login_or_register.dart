import 'package:flutter/material.dart';
import 'package:mart_app/pages/login_page.dart';

import '../pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  final void Function()? onTap;

  const LoginOrRegister({super.key, required this.onTap});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

  class _LoginOrRegisterState extends State<LoginOrRegister> {

    //initially, show login page
    bool showLoginPage = true;

    //toggle betwen login and register page
    void togglePages() {
      setState(() {
        showLoginPage = !showLoginPage;
      });
    }


    @override 
    Widget build(BuildContext context) {
      if (showLoginPage) {
        return LoginPage(onTap: togglePages);
      } else {
        return RegisterPage(onTap: togglePages);
      }
    }
  }