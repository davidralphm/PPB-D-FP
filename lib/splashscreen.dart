import 'package:flutter/material.dart';
import 'package:news_app/consts/global_colors.dart';
import 'package:news_app/screens/home_screen.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:kasirapp/main.dart';
import 'dart:async';
import '../auth/login_screen.dart';
import '../auth/signup_screen.dart';
import '../services/main_model.dart';
import '../../utils/pallete.dart';

class SplashScreen extends StatefulWidget {
  final MainModel model;
  SplashScreen(this.model);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? _uid, _nama;

  startTime() async {
    return Timer(
        Duration(seconds: 5),
        () => _uid == null
            ? Navigator.of(context).pushReplacementNamed('/onboard')
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen(
                        // widget.model, _uid!, _nama!
                        ))));
  }

  @override
  void initState() {
    super.initState();

    widget.model.checkUid().then((data) {
      setState(() {
        _uid = data['uid'];
        _nama = data['nama'];
      });
      print("UID LOGIN: $_uid");
      print("UID MODEL: ${widget.model.uid}");
      print("EMAIL: ${widget.model.email}");
      print("NAMA: ${widget.model.nama}");
      startTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkTextColor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 250,
                      child: Image.asset(
                        'assets/images/newspaper.png',
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Viral Newz",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: ConstColors.textColor),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
