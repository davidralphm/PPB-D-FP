import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:highlights/screens/homescreen.dart';
import '../utils/appcolors.dart';
import '../widgets/apptext.dart';
import '../widgets/expanded_button_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.onTap});

  final Function()? onTap;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = '';
  String password = '';
  String passwordConfirmation = '';

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator()
        );
      }
    );

    try {
      if (password == passwordConfirmation) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
        );

        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        showErrorMessage('Passwords don\'t match!');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      switch (e.code) {
        case 'invalid-email':
          showErrorMessage('Incorrect email format');
          break;

        case 'email-already-in-use':
          showErrorMessage('Email already in use');
          break;
        
        case 'weak-password':
          showErrorMessage('Weak password');
          break;

        default:
          showErrorMessage('Registration error');
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
            text: "R e g i s t e r",
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

              TextField(
                decoration: const InputDecoration(
                    labelText: 'Confirm password',
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
                    passwordConfirmation = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              const Spacer(),
              const SizedBox(height: 20),
              ExpandedButton(
                buttonColor: AppColors.primaryColor.withOpacity(1),
                onPressed: signUserUp,
                child: const AppText(
                  text: "Register",
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
                    Text('Already have an account yet? ', style: TextStyle(fontSize: 15.0),),
                    GestureDetector(
                      child: Text('Login now', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15.0)),
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
