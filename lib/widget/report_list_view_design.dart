import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayeh/model/report.dart';
import 'package:tayeh/screens/chat_screen.dart';

import 'image_to_full_screen.dart';

class ReportListViewDesgin extends StatelessWidget {

  void goToChat(BuildContext context,String peerID) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  peerId: "$peerID",
                )));
  }


  @override
  Widget build(BuildContext context) {
    final report = Provider.of<Report>(context);

    return Column(
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width - 40,
            color: Colors.black12,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context,ImageToFullScreen.routeName,arguments: ['' , report.reportingUserPostImage]);
                  },
                  child: Container(
                      height: 250,
                      width: (MediaQuery.of(context).size.width - 40) / 2,
                      child: Image.network(
                        report.reportingUserPostImage,
                        fit: BoxFit.cover,
                      )),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context,ImageToFullScreen.routeName,arguments: ['' , report.reportedPostImage]);
                  },
                  child: Container(
                      height: 250,
                      width: (MediaQuery.of(context).size.width - 40) / 2,
                      child: Image.network(
                        report.reportedPostImage,
                        fit: BoxFit.cover,
                      )),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          height: 50,
          width: (MediaQuery.of(context).size.width - 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: ()=> goToChat(context
                    ,report.reportingUserID),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.chat_bubble,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Chat with reporter',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: ()=> goToChat(context,report.reportedPostOwnerID
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.chat_bubble,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Chat with reported',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 40),
          child: Divider(
            thickness: 1,
          ),
        )
      ],
    );
  }
}
