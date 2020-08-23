import 'package:easy_localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayeh/model/post.dart';
import 'package:tayeh/provider/posts.dart';
import 'package:tayeh/provider/users.dart';
import 'package:tayeh/screens/edit_post_screen.dart';
import 'package:tayeh/screens/filter_screen.dart';
import 'package:tayeh/screens/similar_posts_screen.dart';
import 'package:tayeh/widget/filter_result_listview_design.dart';
import 'package:tayeh/widget/home_list_view_design.dart';
import 'package:tayeh/widget/machine_learning_listview_design.dart';

class ManagePostsListViewDesign extends StatefulWidget {
  final String state;

  const ManagePostsListViewDesign({this.state});

  @override
  _ManagePostsListViewDesignState createState() =>
      _ManagePostsListViewDesignState(state);
}

class _ManagePostsListViewDesignState extends State<ManagePostsListViewDesign> {
  String state;

  _ManagePostsListViewDesignState(this.state);

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context);
//    print('object' + post.idPost);
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10),
        child: Container(
          child: Column(
            children: <Widget>[
              InkWell(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 25,
                      backgroundImage: AssetImage("assets/images/avatar.jpg"),
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
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 11),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(post.imageUrl))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
//                        print('state' + state);
                        Navigator.of(context).pushNamed(
                            EditPostScreen.routeName,
                            arguments: [state, post]);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.edit, color: Colors.green),
                          SizedBox(
                            width: 6,
                          ),
                          Text(Localization.instance.tr("EditPost")),
                        ],
                      ),
                    ),
                    !post.isReported
                        ? InkWell(
                            onTap: () async {
                              await Provider.of<Posts>(context, listen: false)
                                  .deleteFileFromStorage(post.imageUrl);
                              await Provider.of<Posts>(context, listen: false)
                                  .deletePosts(post.idPost, state);
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(Localization.instance.tr("DeletePost")),
                              ],
                            ),
                          )
                        : Container(),
                    state == 'post_lost' && !Users.currentUser.data['admin']
                        ? InkWell(
                            onTap: () async {
//                        final res =
//                            await Navigator.of(context).pushNamed(FilterScreen.routName) as List;
//                        if (res != null) {
//                          res[0] ?
//                          setState(() {
//                            HomeListViewDesign.lostChildAge = res[1];
//                            HomeListViewDesign.lostChildGender =
//                            res[2] == null ? null : (res[2] ? 'Male' : 'Female');
//                          }) : setState(() {
//                            HomeListViewDesign.foundChildAge = res[1];
//                            HomeListViewDesign.foundChildGender =
//                            res[2] == null ? null : (res[2] ? 'Male' : 'Female');
//                          });
//                        }

                              FilterResultListViewDesign.postReportingID =
                                  post.idPost;
                              FilterResultListViewDesign.postReportingUserID =
                                  post.ownerId;
                              SimilarPostsScreen.imageUrl = post.imageUrl;
                              FilterResultListViewDesign.postReportingImageURL =
                                  post.imageUrl;

                              MachineLearningListViewDesign.postReportingID =
                                  post.idPost;
                              MachineLearningListViewDesign
                                  .postReportingUserID = post.ownerId;
                              MachineLearningListViewDesign.postReportingImageURL = post.imageUrl;

//                        print('1 -- ' +FilterResultListViewDesign.postReportingImageURL );
                              await Navigator.of(context)
                                      .pushNamed(SimilarPostsScreen.routeName)
                                  as List;
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.format_list_numbered,
                                    color: Colors.green),
                                SizedBox(
                                  width: 6,
                                ),
                                Text('Similar Posts'),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
