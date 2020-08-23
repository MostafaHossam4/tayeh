import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayeh/model/post.dart';
import 'package:tayeh/screens/similar_posts_screen.dart';
import 'package:tayeh/widget/filter_result_listview_design.dart';
import 'package:tayeh/widget/machine_learning_listview_design.dart';
import 'package:tayeh/widget/manage_posts_listview_design.dart';

class MachineLearningScreen extends StatefulWidget {
  @override
  _MachineLearningScreenState createState() => _MachineLearningScreenState();
}

class _MachineLearningScreenState extends State<MachineLearningScreen> {
  List<dynamic> _similar = [];
  FormData _formData;

  machine() async {
    _formData = FormData.fromMap({
      "idPost": FilterResultListViewDesign.postReportingID,
      "status": "lost_child",
      "imageUrl": SimilarPostsScreen.imageUrl,
      "requestType": 2
    });
    try {
      Response response = await Dio()
          .post("http://tayehapi.ddns.net:8000/generic/posts/", data: _formData);
      try{
        setState(() {
          _similar = response.data;
        });
      }catch(e){

      }

      print(_similar.toString());
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        print("success");
      } else {
        print('not a 200 requesy ${response.data}');
        print("something is wrong");
      }
    } on DioError catch (e) {
      print(e.response);
      return e.response.data["message"];
    }
  }

  @override
  void initState() {
    machine();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final databaseReference = Firestore.instance;
    final List<Post> allPosts = [];
    return StreamBuilder<QuerySnapshot>(
        stream: databaseReference.collection('post_found').snapshots(),
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
            print(_similar.contains(post.documentID));
            print(post.documentID);
            if (_similar.contains(post.documentID)) {
              allPosts.insert(
                  0,
                  Post(
                      idPost: post.documentID,
                      gender: post.data['gender'].toString().split('.').last,
                      description: post.data['description'].toString(),
                      name: post.data['name'].toString(),
                      age: post.data['age'].toString(),
                      imageUrl: post.data['imageUrl'].toString(),
                      location: post.data['location'].toString(),
                      public: post.data['public'],
                      time: post.data['time'].toString(),
                      ownerId: post.data['ownerId'].toString(),
                      ownerName: post.data['ownerName'].toString(),
                      isReported: post.data['isReported']));
            }
          }
          print('->>' + allPosts.toString());
          if (allPosts.length == 0) {
            return Center(
              child: Text('There is no matching posts for your post'),
            );
          }
          return Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: allPosts.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: allPosts[i],
                child: MachineLearningListViewDesign(),
              ),
            ),
          );
        });
  }
}
