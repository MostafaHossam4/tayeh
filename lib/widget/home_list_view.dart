import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayeh/widget/home_list_view_design.dart';
import '../model/post.dart';

class HomeListView extends StatefulWidget {
  final String state;

  const HomeListView({this.state});

  @override
  _HomeListViewState createState() => _HomeListViewState(state);
}

class _HomeListViewState extends State<HomeListView> {
  String state;

  _HomeListViewState(this.state);

  @override
  Widget build(BuildContext context) {
    final databaseReference = Firestore.instance;
    final List<Post> allPosts = [];
    return StreamBuilder<QuerySnapshot>(
        stream: databaseReference.collection(state).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ));
          }
          final posts = snapshot.data.documents;
          allPosts.clear();
          for (var post in posts) {
            if (post.data['public'] == true) {
              allPosts.add(Post(
                  gender: post.data['gender'].toString().split('.').last,
                  description: post.data['description'].toString(),
                  name: post.data['name'].toString(),
                  age: post.data['age'].toString(),
                  imageUrl: post.data['imageUrl'].toString(),
                  location: post.data['location'].toString(),
                  public: post.data['public'],
                  time: post.data['time'].toString(),
                  ownerName: post.data['ownerName'].toString(),
                  encoding: post.data['encoding'],
                  idPost: post.documentID,
                  isReported: post.data['isReported'],
                  timeStamp: post.data['timeStamp']));
              allPosts.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
            }
          }
          if (allPosts.length == 0) {
            return Center(
              child: state == 'post_found'
                  ? Text(Localization.instance.tr("ThereisnoPosts"),)
                  : Text(Localization.instance.tr("ThereisnoPosts"),),
            );
          }
          return Container(
            child: ListView.builder(
              addAutomaticKeepAlives: true,
              cacheExtent: 9999999,
              scrollDirection: Axis.vertical,
              itemCount: allPosts.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: allPosts[i],
                child: HomeListViewDesign(
                  state: state,
                ),
              ),
            ),
          );
        });
  }
}
