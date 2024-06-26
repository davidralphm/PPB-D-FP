import 'package:flutter/cupertino.dart';
import 'package:highlights/services/firestore.dart';
import 'package:highlights/widgets/news_widget_stateful.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed_plus/webfeed_plus.dart';
import 'package:flutter/material.dart';
import 'package:webfeed_plus/domain/rss_feed.dart';

import '../../utils/appcolors.dart';
import '../widgets/apptext.dart';

class ViewMore extends StatefulWidget {

  final String name;
  final String getURL;
  const ViewMore({super.key, required this.getURL, required this.name});

  @override
  _ViewMoreState createState() => _ViewMoreState();
}

class _ViewMoreState extends State<ViewMore> {
  RssFeed? feed;
  late Map<String, dynamic> favList = {};

  @override
  void initState() {
    super.initState();
    loadFeed();
  }

  Future<void> loadFeed() async {
    favList = await FirestoreService().getFavoritesList();

    var response = await http.get(Uri.parse(widget.getURL));
    if (response.statusCode == 200) {
      setState(() {
        feed = RssFeed.parse(response.body);
      });
    } else {
      throw Exception('Failed to load RSS feed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left), onPressed: () {
            Navigator.pop(context);
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthScreen()));
        },
        ),
        title:  AppText(
          text: widget.name,
          fontSize: 18.0,
          color: AppColors.blackColor,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SizedBox(
        child: feed == null
            ? const Center(
          child: CupertinoActivityIndicator(),
        )
            : ListView.builder(
          shrinkWrap: true,
          itemCount: feed!.items?.length,
          // itemCount: 2,
          itemBuilder: (context, index) {
            var item = feed!.items?[index];
            return NewsWidgetStateful(
                title: item?.title ?? '',
                subtitle: "",
                publishDate: item?.pubDate?.toString() ?? "",
                author: item?.source?.url.toString() ?? "",
                link: item?.link?.toString() ?? "",
                bookmarked: favList.containsKey(item?.guid),
                guid: item?.guid ?? "",
              );
          },
        ),
      ),
    );
  }
}