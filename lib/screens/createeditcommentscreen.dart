import 'package:highlights/services/firestore.dart';
import 'package:highlights/utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:highlights/widgets/expanded_button_widget.dart';
import '../widgets/apptext.dart';

class CreateEditCommentScreen extends StatefulWidget {
  final String commentDocId;
  final String comment;
  final String newsGuid;
  final String userUid;
  final String username;

  const CreateEditCommentScreen(
    {
      super.key,
      required this.commentDocId,
      required this.comment,
      required this.newsGuid,
      required this.userUid,
      required this.username,
    }
  );

  @override
  _CreateEditCommentScreenState createState() => _CreateEditCommentScreenState();
}

class _CreateEditCommentScreenState extends State<CreateEditCommentScreen> {
  TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    commentController.text = widget.comment;

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
            title: AppText(
              text: '${(widget.commentDocId == '') ? 'A D D' : 'E D I T'}   C O M M E N T',
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
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Comment',
                  labelStyle: TextStyle(color: AppColors.blackColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blackColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),

                controller: commentController,
                minLines: 10,
                maxLines: 10,
              ),

              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandedButton(
                  buttonColor: AppColors.warningColor,
                  onPressed: () async {
                    if (commentController.text == '') {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            title: Text('Comment body cannot be empty!'),
                          );
                        }
                      );
                    }

                    if (widget.commentDocId != '') {
                      FirestoreService().updateComment(widget.commentDocId, commentController.text);

                      Navigator.pop(context);
                      return;
                    }

                    FirestoreService().addComment(
                      widget.newsGuid, 
                      widget.userUid, 
                      widget.username, 
                      commentController.text
                    );

                    Navigator.pop(context);
                  },
                  child: const AppText(
                    text: "Save",
                    fontSize: 18.0,
                    color: AppColors.whiteColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
