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

                      return NewsWidget(title: 'asd', subtitle: 'asd', publishDate: '2020-10-10 10:10:10', author: 'asd', link: url, bookmarked: true);
                      // return ListTile(
                      //   title: Text(url),
                      //   trailing: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       IconButton(onPressed: () => { FirestoreService().deleteFavorite(url) }, icon: const Icon(Icons.delete))
                      //     ],
                      //   )
                      //   );
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
