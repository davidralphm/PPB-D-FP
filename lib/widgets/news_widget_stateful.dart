import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlights/screens/commentsscreen.dart';
import 'package:highlights/services/firestore.dart';
import 'package:highlights/utils/appcolors.dart';

import '../utils/helper/author_function.dart';
import '../utils/helper/date_functions.dart';
import 'apptext.dart';
import 'news_webview.dart';

class NewsWidgetStateful extends StatefulWidget {
  final String title;
  final String subtitle;
  final String publishDate;
  final String author;
  final String link;
  final bool bookmarked;
  final String guid;

  const NewsWidgetStateful({
    required this.title,
    required this.subtitle,
    required this.publishDate,
    required this.author,
    required this.link,
    required this.bookmarked,
    required this.guid
  });

  @override
  State<NewsWidgetStateful> createState() => _NewsWidgetStatefulState();
}

class _NewsWidgetStatefulState extends State<NewsWidgetStateful> {
  bool isBookmarked = false;

  @override
  void initState() {
    isBookmarked = widget.bookmarked;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   title,
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),

                AppText(
                  text: widget.title,
                  fontSize: 16.0,
                  color: Colors.black,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Text(
                //   subtitle,
                //   style: TextStyle(fontSize: 16),
                // ),
                // SizedBox(height: 8),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text:  convertToRegularDateFormat(widget.publishDate),
                          fontSize: 12.0,
                          color: AppColors.blackColor.withOpacity(0.5),
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            AppText(
                             text:  'By ',
                              fontSize: 12.0,
                              color: AppColors.blackColor.withOpacity(0.5),
                              fontWeight: FontWeight.normal,
                              overflow: TextOverflow.ellipsis,
                            ),
                            AppText(
                              text:  removeHttpsAndCom(widget.author),
                              fontSize: 12.0,
                              color: AppColors.blackColor.withOpacity(1),
                              fontWeight: FontWeight.normal,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),

                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsScreen(newsGuid: widget.guid)));
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CommentsScreen(newsGuid: widget.guid)));
                      },

                      icon: const Icon(Icons.comment_outlined),
                    ),

                    IconButton(
                      onPressed: () {
                        if (isBookmarked) {
                          FirestoreService().deleteFavorite(widget.guid);
                        } else {
                          FirestoreService().addFavorite(
                            widget.title,
                            widget.subtitle,
                            widget.publishDate,
                            widget.author,
                            widget.link,
                            widget.guid
                          );
                        }

                        setState(() {
                          isBookmarked = !isBookmarked;
                        });
                      },

                      icon: Icon(
                        (isBookmarked == true) ? Icons.bookmark : Icons.bookmark_outline
                      ),
                    ),

                    Container(
                      width: 100, // Width of the oval button
                      height: 30, // Height of the oval button
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.7),
                        borderRadius:
                        BorderRadius.circular(25), // Half of the height
                      ),
                      child: TextButton(
                        onPressed: () {
<<<<<<< HEAD
                          // Add item to news history
                          FirestoreService().addHistory(
                            widget.title,
                            widget.subtitle,
                            widget.publishDate,
                            widget.author,
                            widget.link,
                            widget.guid
                          );

=======
>>>>>>> d1c1e62fcb2b314eb15a2f7926c8faaee44178f1
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NewsWebviewApp(newsURL: widget.link,)),
                          );
                        },
                        child: const AppText(
                          text: "V I S I T",
                          fontSize: 12.0,
                          color: Colors.black,
                          maxLines: 4,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10,),
                const Divider()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
