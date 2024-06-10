import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:highlights/services/firestore.dart';
import 'package:highlights/utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:highlights/widgets/news_widget.dart';
import 'package:highlights/widgets/news_widget_stateful.dart';
import '../widgets/apptext.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Map<String, dynamic> favList = {};

  void loadFavList() async {
    favList = await FirestoreService().getFavoritesList();
  }

  @override
  void initState() {
    loadFavList();
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
                Navigator.pop(context);
              }),
            backgroundColor: AppColors.primaryColor,
            title: const AppText(
              text: "N E W S   H I S T O R Y",
              fontSize: 18.0,
              color: AppColors.blackColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          body: 
              StreamBuilder<DocumentSnapshot>(
                stream: FirestoreService().getHistoryStream(),
                builder: (context, snapshot) {
                  try {
                    final historyList = snapshot.data!.data() as Map<String, dynamic>;
                    List list = [];

                    historyList.forEach((key, value) {
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
                      return NewsWidgetStateful(
                        title: list[index]['title'],
                        subtitle: list[index]['subtitle'],
                        publishDate: list[index]['publishDate'],
                        author: list[index]['author'],
                        link: list[index]['link'],
                        bookmarked: favList.containsKey(list[index]['guid']),
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
