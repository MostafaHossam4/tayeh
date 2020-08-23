import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:tayeh/model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './users.dart';
import 'dart:io';

import 'package:dio/dio.dart';

class Posts with ChangeNotifier {
  final databaseReference = Firestore.instance;
  List<Post> _posts = [];
  List<DocumentSnapshot> _allIdUsers= [];


  Future<void> createPost(String userID, Post post,String state) async {
    FormData _formData;

   DocumentReference Doc = await databaseReference.collection(state).document();
        Doc.setData({
      'age': post.age,
      'description': post.description,
      'gender': post.gender.toString().split('.').last,
      'imageUrl': post.imageUrl,
      'location': post.location,
      'name': post.name,
      'public': post.public,
      'time': post.time,
      'ownerId': userID,
      'ownerName':Users.currentUser.data['name'],
      'encoding' : post.encoding,
      'timeStamp' : post.timeStamp,
      'isReported' : false,
    }).catchError((error) {
      throw error;
    });



    if(state == 'post_found'){
      print("////////////////////////////");
      print(post.imageUrl);
      _formData = FormData.fromMap({
        "idPost": Doc.documentID,
        "status": state,
        "imageUrl": post.imageUrl ,
        "requestType": 1
      });
      try {
        Response response =
        await Dio().post("http://tayehapi.ddns.net:8000/generic/posts/", data: _formData);
        print(response.data);
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          return "success";
        } else {;
          return "something is wrong";
          print('not a 200 requesy ${response.data}')
        }
      } on DioError catch (e) {
        print(e.response);
        return e.response.data["message"];
      }
    }




  }

  Future<void> deletePosts(String postId,String state) async {
    await databaseReference
        .collection(state)
        .document(postId)
        .delete().catchError((error) {
      throw error;
    });
   
    ///`Deletes the image from the storage with the image url (reference)`

  }

  Future<void> deleteFileFromStorage(String url) async{
     await FirebaseStorage.instance.getReferenceFromUrl(url).then((image){
      image.delete();
    });
  }

  Future<void> updatePost(String puid,Post post,String state) async{
    print('object 3 ' + puid.toString());
    await databaseReference.collection(state).document(puid).updateData({
      'age': post.age,
      'description': post.description,
      'gender': post.gender.toString().split('.').last,
      'imageUrl': post.imageUrl,
      'location': post.location,
      'name': post.name,
      'public': post.public,
      'time': post.time,      
      }
    );
  }

  void clearAllPosts(){
     _posts.clear();
     _allIdUsers.clear();
    notifyListeners();
  }



}
