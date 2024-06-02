import 'package:flutter/material.dart';
import 'package:highlights/screens/authscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

///  Created by Shreyas Vilaschandra Bhike on 24/03/24.

/// Instagram
/// TheAppWizard
/// theappwizard2408

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'H I G H L I G H T S',
      home: AuthScreen(),
    );
  }
}









