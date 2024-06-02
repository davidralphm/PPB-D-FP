import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:highlights/screens/favoritesscreen.dart';
import 'package:highlights/screens/homescreen.dart';
import 'package:highlights/screens/loginorregisterscreen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
            // return const FavoritesScreen();
          }

          return const LoginOrRegisterScreen();
        },
      ),
    );
  }
}