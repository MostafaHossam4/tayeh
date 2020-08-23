import 'package:flutter/material.dart';
import 'package:tayeh/model/post.dart';
import 'package:tayeh/screens/filter_screen.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tayeh/screens/machinelearning_screen.dart';
import 'package:tayeh/widget/filter_result_listview_design.dart';

class SimilarPostsScreen extends StatelessWidget {
  static const routeName = '/similarposts';
  static String imageUrl ;
  final Post post;
  SimilarPostsScreen({this.post});
  List<String> _similar =[];
  FormData _formData;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Similar posts',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            bottom: TabBar(
              labelColor: Theme.of(context).primaryColor,
              tabs: [
                Tab(
                  text: 'Mahcine',
                ),
                Tab(
                  text: 'Filter',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
//              Center(
//                  child: FlatButton(
//                child: Text('Machine'),
//                onPressed: () async {
//                  _formData = FormData.fromMap({
//                    "idPost": FilterResultListViewDesign.postReportingID,
//                    "status": "lost_child",
//                    "imageUrl": SimilarPostsScreen.imageUrl ,
//                    "requestType": 2
//                  });
//                  try {
//                    Response response =
//                        await Dio().post("http://41.45.56.60:8000/generic/posts/", data: _formData);
//                    print(response.data);
//                    _similar = response.data;
//                    if (response.statusCode >= 200 && response.statusCode <= 299) {
//                      return "success";
//                    } else {
//                      print('not a 200 requesy ${response.data}');
//                      return "something is wrong";
//                    }
//                  } on DioError catch (e) {
//                    print(e.response);
//                    return e.response.data["message"];
//                  }
//
//                },
//              )),
              MachineLearningScreen(),
              FilterScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
