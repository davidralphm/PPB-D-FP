import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:highlights/screens/authscreen.dart';
import 'package:highlights/services/firestore.dart';
import 'package:highlights/utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:highlights/widgets/news_widget.dart';
import '../widgets/apptext.dart';

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
          backgroundColor: AppColors.whiteColor,
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.chevron_left), onPressed: () {
                // Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
              }),
            backgroundColor: AppColors.primaryColor,
            title: const AppText(
              text: "F A V O R I T E S",
              fontSize: 18.0,
              color: AppColors.blackColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          body: 
              StreamBuilder<DocumentSnapshot>(
                stream: FirestoreService().getFavoritesStream(),
                builder: (context, snapshot) {
                  try {
                    final favList = snapshot.data!.data() as Map<String, dynamic>;
                    List list = [];

                    print(favList);

                    favList.forEach((key, value) {
                      value['guid'] = key;
                      list.add(value);
                    });

                    if (list.isEmpty) {
                      return const Center(
                        child: Text('No items', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                      );
                    }

                    return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return NewsWidget(
                        title: list[index]['title'],
                        subtitle: list[index]['subtitle'],
                        publishDate: list[index]['publishDate'],
                        author: list[index]['author'],
                        link: list[index]['link'],
                        bookmarked: true,
                        guid: list[index]['guid'],
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
