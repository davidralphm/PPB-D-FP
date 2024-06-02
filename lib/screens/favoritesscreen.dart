

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:highlights/screens/profilescreen.dart';
import 'package:highlights/services/firestore.dart';
import 'package:highlights/utils/appcolors.dart';
import 'package:highlights/widgets/news_widget.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed_plus/webfeed_plus.dart';
import 'package:flutter/material.dart';
import 'package:webfeed_plus/domain/rss_feed.dart';

import '../utils/onboarding_util/topics.dart';
import '../widgets/apptext.dart';
import '../widgets/capsule_widget.dart';
import '../widgets/subwidgets/home_section_country.dart';
import '../widgets/subwidgets/home_section_geo.dart';
import '../widgets/subwidgets/home_section_tab.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              FirestoreService().addFavorite('asda');
            },

            child: const Icon(Icons.add),
          ),
          backgroundColor: AppColors.whiteColor,
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.chevron_left), onPressed: () {
                Navigator.pop(context);
              }),
            backgroundColor: AppColors.primaryColor,
            title: const AppText(
              text: "H I G H L I G H T S",
              fontSize: 18.0,
              color: AppColors.blackColor,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen()),
                    );
                  },
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    color: AppColors.blackColor,
                  ))
            ],
          ),
          body: 
              StreamBuilder<DocumentSnapshot>(
                stream: FirestoreService().getFavoritesStream(),
                builder: (context, snapshot) {
                  try {
                    final doc = snapshot.data!.data() as Map<String, dynamic>;

                    List favList = doc['url'];

                    if (favList.isEmpty) {
                      return const Center(
                        child: Text('No items', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                      );
                    }

                    return ListView.builder(
                    itemCount: favList.length,
                    itemBuilder: (context, index) {
                      String url = favList[index];

                      return ListTile(
                        title: Text(url),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: () => { FirestoreService().deleteFavorite(url) }, icon: const Icon(Icons.delete))
                          ],
                        )
                        );
                      },
                    );
                  } catch(e) {
                    return const Center(
                      child: Text('No items', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                    );
                  }
                },
              )
          ),
    );
  }
}
