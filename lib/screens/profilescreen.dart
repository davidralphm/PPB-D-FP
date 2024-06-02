import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:highlights/screens/authscreen.dart';
import 'package:highlights/screens/splashscreen.dart';
import 'package:highlights/utils/helper/data_functions.dart';

import '../utils/appcolors.dart';
import '../utils/appconstants.dart';
import '../widgets/apptext.dart';
import '../widgets/expanded_button_widget.dart';
import '../widgets/profilecard_widget.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left), onPressed: () {
          Navigator.pop(context);
        },
        ),
        title: const AppText(
          text: "P r o f i l e",
          fontSize: 18.0,
          color: AppColors.blackColor,
          overflow: TextOverflow.ellipsis,
        ),
      ),

      body:  Column(
        children: [
          const SizedBox(height: 20,),
          const ProfileCard(),
          const SizedBox(height: 20,),
          const Divider(),
           ListTile(
            title: AppText(
              text: "Email",
              fontSize: 14.0,
              color: AppColors.blackColor.withOpacity(0.6),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: AppText(
              text: "${widget.user.email}",
              fontSize: 20.0,
              color: AppColors.blackColor,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.normal,
            ),

          ),
           ListTile(
            title: AppText(
              text: "Language",
              fontSize: 14.0,
              color: AppColors.blackColor.withOpacity(0.6),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: const AppText(
              text: "asd",
              fontSize: 20.0,
              color: AppColors.blackColor,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.normal,
            ),

          ),

          const Spacer(),
          const AppText(
            text: "1.0.0 Version",
            fontSize: 12.0,
            color: AppColors.blackColor,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.normal,
          ),


          const SizedBox(height: 20,),
          const Divider(),
          const SizedBox(height: 20,),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpandedButton(
              buttonColor: AppColors.errorColor.withOpacity(1),
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              child: const AppText(
                text: "Logout",
                fontSize: 18.0,
                color: AppColors.whiteColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(height: 30,),
        ],
      )
    );
  }
}


