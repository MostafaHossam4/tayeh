import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:tayeh/provider/users.dart';
import 'package:tayeh/utilities/constrains.dart';

import 'chat_screen.dart';
import 'home_screen.dart';

class MenuChatAdmin extends StatefulWidget {
  static String routeName = "/menuchatadmin";
  @override
  State createState() => MenuChatAdminState();
}

class MenuChatAdminState extends State<MenuChatAdmin> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme
            .of(context)
            .buttonColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme
              .of(context)
              .buttonColor,
          title: Text(
            "Chats",
            style: TextStyle(fontSize: 25),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 25,
              ),
              onPressed: () =>
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routName)),
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            Container(
              color: Theme
                  .of(context)
                  .buttonColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 243, 243, 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black87,
                        ),
                        hintText: "Search For User's",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: StreamBuilder(
                  stream: Firestore.instance.collection('users').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemBuilder: (context, index) =>
                            buildItem(context, snapshot.data.documents[index]),
                        itemCount: snapshot.data.documents.length,
                      );
                    }
                  },
                ),
              ),
            )
          ],
        )

      // Loading
//            Positioned(
//              child: isLoading
//                  ? Container(
//                child: Center(
//                  child: CircularProgressIndicator(
//                      valueColor:
//                      AlwaysStoppedAnimation<Color>(themeColor)),
//                ),
//                color: Colors.white.withOpacity(0.8),
//              )
//                  : Container(),
//            )

    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    //Return Documents of users
    if (document.documentID == Users.currentUser.documentID) {
      // user cannot chat with himself =D

      return Container();
    } else {
      return Container(
        child: FlatButton(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Material(
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: AssetImage("assets/images/avatar.jpg"),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                clipBehavior: Clip.hardEdge,
                  ),
                  Flexible(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              '${document['name']}',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 20,
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                          ),
                          Container(
                            child: Text(
                              'hello',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                          ),
                        ],
                      ),
//                  margin: EdgeInsets.only(left: 0.0),
                    ),
                  ),
                  Text(
                    '5:00',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 2,
                thickness: 1,
              )
            ],
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Chat(
                          peerId: document.documentID,
                        )));
          },
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 0.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }
}
