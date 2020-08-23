import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayeh/model/post.dart';
import 'package:tayeh/model/report.dart';
import 'package:tayeh/provider/reports.dart';
import 'package:tayeh/widget/image_to_full_screen.dart';
import 'package:toast/toast.dart';

class MachineLearningListViewDesign extends StatelessWidget {

  static String foundChildGender;
  static double foundChildAge;

  static String postReportingID;
  static String postReportingUserID;
  static String postReportingImageURL;

  Future showToast(BuildContext context, String msg) {
    Toast.show("$msg", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
  Future _showMyDialog(BuildContext context) async {
    final post = Provider.of<Post>(context);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Report!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You are about to report this post to admins\n'),
                Text(
                    'Only report this post if you are sure that this post is similar to your post'),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                  child: Text('Proceed'),
                  onPressed: () async {
                    //TODO report post to admins
                    Provider.of<Reports>(context).createReport(
                        report: Report(
                            reportedPostImage: post.imageUrl,
                            reportedPostID: post.idPost,
                            reportedPostOwnerID: post.ownerId,
                            reportingUserID: postReportingUserID,
                            reportingUserPostID: postReportingID,
                            reportingUserPostImage: postReportingImageURL));
                    await showToast(
                        context, 'Post has been reported successfully');
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context);
    print('Here ' + post.idPost);
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        // right: 20,
        // left: 20
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 25,
                    backgroundImage:
                    AssetImage("assets/images/avatar.jpg"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        post.ownerName,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        post.time,
                        style: TextStyle(
                            color: Colors.grey[400], fontSize: 11),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _showMyDialog(context),
                    child: Icon(Icons.report),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ImageToFullScreen.routeName,
                    arguments: [post.ownerName, post.imageUrl]);
              },
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(post.imageUrl))),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 100,
            child: Divider(
              color: Colors.grey[300],
              height: 1,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
