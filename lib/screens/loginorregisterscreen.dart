import 'package:flutter/material.dart';
import 'package:highlights/screens/loginscreen.dart';
import 'package:highlights/screens/registerscreen.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  // Show login page
  bool showLoginpage = true;

  // Toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginpage = !showLoginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginpage) {
      return LoginScreen(onTap: togglePages);
    }

    return RegisterScreen(onTap: togglePages,);
  }
}