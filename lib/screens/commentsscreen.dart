import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:highlights/screens/createeditcommentscreen.dart';
import 'package:highlights/services/firestore.dart';
import 'package:highlights/utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:highlights/widgets/comment_widget.dart';
import 'package:intl/intl.dart';
import '../widgets/apptext.dart';

class CommentsScreen extends StatefulWidget {
  final String newsGuid;

  const CommentsScreen({super.key, required this.newsGuid});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateEditCommentScreen(
                    commentDocId: '',
                    comment: '',
                    newsGuid: widget.newsGuid,
                    userUid: FirebaseAuth.instance.currentUser?.uid ?? '',
                    username: FirebaseAuth.instance.currentUser?.email ?? ''
                  )
                )
              );
            },

            child: const Icon(Icons.comment),
          ),
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.chevron_left), onPressed: () {
                Navigator.pop(context);
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
              }),
            backgroundColor: AppColors.primaryColor,
            title: const AppText(
              text: "C O M M E N T S",
              fontSize: 18.0,
              color: AppColors.blackColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          body: 
              StreamBuilder<QuerySnapshot>(
                stream: FirestoreService().getCommentsStream(widget.newsGuid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final comments = snapshot.data!.docs;

                    if (comments.isEmpty) {
                      return const Center(
                        child: Text(
                          'No comments yet',
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final milliseconds = DateTime.fromMillisecondsSinceEpoch(comments[index]['timestamp'].seconds * 1000);
                        String publishDate = DateFormat('dd/MM/yyyy - HH:mm').format(milliseconds);

                        return CommentWidget(
                          comment: comments[index]['comment'],
                          publishDate: publishDate,
                          userUid: comments[index]['userUid'],
                          username: comments[index]['username'],
                          newsGuid: comments[index]['newsGuid'],
                          commentDocId: comments[index].id
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'No comments yet',
                        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)
                      ),
                    );
                  }
                },
              )
          ),
    );
  }
}
