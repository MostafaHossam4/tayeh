import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayeh/model/post.dart';
import 'package:tayeh/provider/users.dart';
import 'manage_posts_listview_design.dart';



class ManagePostsListView extends StatefulWidget {
  final String state;

  const ManagePostsListView({this.state});
  @override
  _ManagePostsListViewState createState() => _ManagePostsListViewState(state);
}

class _ManagePostsListViewState extends State<ManagePostsListView> {
  String state;
  _ManagePostsListViewState(this.state);
  @override
  Widget build(BuildContext context) {
    final databaseReference = Firestore.instance;
    final List<Post> allPosts = [];
    return
      StreamBuilder<QuerySnapshot>(
          stream: databaseReference.collection(state).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.amber,
                  ));
            }
            final posts = snapshot.data.documents;
            allPosts.clear();
            for (var post in posts) {
              if(post.data['ownerName'] == Users.currentUser.data['name']){
                allPosts.insert(
                    0,
                    Post(
                      idPost: post.documentID,
                      gender:
                      post.data['gender'].toString().split('.').last,
                      description: post.data['description'].toString(),
                      name: post.data['name'].toString(),
                      age: post.data['age'].toString(),
                      imageUrl: post.data['imageUrl'].toString(),
                      location: post.data['location'].toString(),
                      public: post.data['public'],
                      time: post.data['time'].toString(),
                      ownerId: post.data['ownerId'].toString(),
                      ownerName: post.data['ownerName'].toString(),
                      isReported: post.data['isReported']
                    ));
              }
            }
            if (allPosts.length == 0) {
              return Center(
                  child: state== 'post_found'? Text('There is no Found Posts'):Text('There is no Lost Posts'),
              );
            }
            return Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: allPosts.length,
                itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: allPosts[i],
                  child: ManagePostsListViewDesign(state: state,),
                ),
              ),
            );
          });
  }
}
