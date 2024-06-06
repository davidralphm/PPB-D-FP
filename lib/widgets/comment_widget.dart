import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:highlights/screens/createeditcommentscreen.dart';
import 'package:highlights/services/firestore.dart';
import 'package:highlights/utils/appcolors.dart';
import 'apptext.dart';

class CommentWidget extends StatelessWidget {
  final String comment;
  final String publishDate;
  final String userUid;
  final String username;
  final String newsGuid;
  final String commentDocId;

  const CommentWidget({
    super.key,
    required this.comment,
    required this.publishDate,
    required this.userUid,
    required this.username,
    required this.newsGuid,
    required this.commentDocId
  });

  Widget buildDeleteButton(BuildContext context) {
    if (userUid != FirebaseAuth.instance.currentUser?.uid) return Container();

    return IconButton(
      onPressed: () async {
        bool confirmation = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Delete comment'),
              content: const Text('Are you sure you want to delete this comment?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('No')
                ),

                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Yes')
                ),
              ],
            );
          }
        );

        if (confirmation) FirestoreService().deleteComment(commentDocId);
      },

      icon: const Icon(Icons.delete_outline),
    );
  }

  Widget buildEditButton(BuildContext context) {
    if (userUid != FirebaseAuth.instance.currentUser?.uid) return Container();

    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateEditCommentScreen(
              commentDocId: commentDocId,
              comment: comment,
              newsGuid: newsGuid,
              userUid: userUid,
              username: username,
            )
          )
        );
      },

      icon: const Icon(Icons.edit_outlined)
    );
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
                AppText(
                  text: comment,
                  fontSize: 16.0,
                  color: Colors.black,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text:  publishDate,
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
                              text:  username,
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

                    buildDeleteButton(context),
                    buildEditButton(context)
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
