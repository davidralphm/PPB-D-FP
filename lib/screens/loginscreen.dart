import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/appcolors.dart';
import '../widgets/apptext.dart';
import '../widgets/expanded_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onTap});

  final Function()? onTap;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  void signUserIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          showErrorMessage('Incorrect email format');
          break;
        
        case 'invalid-credential':
          showErrorMessage('Invalid credential');

        default:
          showErrorMessage('Login error');
      }
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white)
            ),
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          leading: const Text(""),
          backgroundColor: AppColors.primaryColor,
          title: const AppText(
            text: "L o g i n",
            fontSize: 18.0,
            color: AppColors.blackColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Icon(Icons.lock, size: 50.0),
              SizedBox(height: 50.0,),

              TextField(
                decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: AppColors.blackColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blackColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),


                ),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),

              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: AppColors.blackColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blackColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),


                ),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),

              const SizedBox(height: 20),
              const Spacer(),
              const SizedBox(height: 20),
              ExpandedButton(
                buttonColor: AppColors.primaryColor.withOpacity(1),
                onPressed: signUserIn,
                child: const AppText(
                  text: "Login",
                  fontSize: 18.0,
                  color: AppColors.blackColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Divider(height: 50.0, thickness: 2.0,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account yet? ', style: TextStyle(fontSize: 15.0),),
                    GestureDetector(
                      child: Text('Register now', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15.0)),
                      onTap: widget.onTap
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
