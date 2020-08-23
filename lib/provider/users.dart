import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tayeh/model/user.dart';

class Users with ChangeNotifier{

  final databaseReference = Firestore.instance;
  List<DocumentSnapshot> _documents;
  static DocumentSnapshot currentUser;


  Future<void> createDataUser(String currentUser,User user) async {
    await databaseReference.collection("users")
        .document(currentUser)
        .setData({
      'national_id_image': user.nationalIdImage,
      'name' : user.name,
      'address' : user.address,
      'gender' : user.gender,
      'national_id': user.nationalId,
      'admin':false
    }).catchError((error){
      throw error;
    });
  }

  //search user in firebase
  Future<void>  getUserData(String currentUser) async{
    await databaseReference.collection('users').getDocuments()
        .then((QuerySnapshot snapshot){
      _documents =   snapshot.documents;
      notifyListeners();
    });
  }

  Future<DocumentSnapshot>  getUser(String currentUser) async{
   await getUserData(currentUser);
      if(_documents.length == 0)
        return null;
      else
        return _documents.firstWhere((user)=> user.documentID.toString() == currentUser , orElse: (){
          return null;
        });
  }







}