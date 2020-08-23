import 'package:flutter/material.dart';
import 'package:tayeh/widget/bottom_navigation_bar.dart';
import 'package:tayeh/widget/drawer.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Notifications',
          style: TextStyle(
              fontSize: 25,
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.lightBlueAccent, size: 35),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),

      ),
      drawer: DrawerScreen(),

      body: new ListView(
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white, style: BorderStyle.solid, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white),
            child: new Card(
              color: Colors.white,
              elevation: 2.0,
              child: new ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  maxRadius: 30,
//                  backgroundImage: AssetImage('assets/images/5.jpg'),
                ),
                title: Text('Title',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                subtitle: Text('subtitle subtitle subtitle subtitle'),
                onTap: () {
                  //code to go to this notification
                },
              ),
            ),
          ),
          new Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white, style: BorderStyle.solid, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white),
            child: new Card(
              color: Colors.white,
              elevation: 2.0,
              child: new ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  maxRadius: 30,
//                  backgroundImage: AssetImage('assets/images/5.jpg'),
                ),
                title: Text('Title',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('subtitle subtitle subtitle subtitle'),
                onTap: () {
                  //code to go to this notification
                },
              ),
            ),
          ),
          new Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white, style: BorderStyle.solid, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white),
            child: new Card(
              color: Colors.white,
              elevation: 2.0,
              child: new ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  maxRadius: 30,
//                  backgroundImage: AssetImage('assets/images/5.jpg'),
                ),
                title: Text('Title',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('subtitle subtitle subtitle subtitle'),
                onTap: () {
                  //code to go to this notification
                },
              ),
            ),
          ),
          new Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white, style: BorderStyle.solid, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white),
            child: new Card(
              color: Colors.white,
              elevation: 2.0,
              child: new ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  maxRadius: 30,
//                  backgroundImage: AssetImage('assets/images/5.jpg'),
                ),
                title: Text('Title',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('subtitle subtitle subtitle subtitle'),
                onTap: () {
                  //code to go to this notification
                },
              ),
            ),
          ),
          new Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white, style: BorderStyle.solid, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white),
            child: new Card(
              color: Colors.white,
              elevation: 2.0,
              child: new ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  maxRadius: 30,
//                  backgroundImage: AssetImage('assets/images/5.jpg'),
                ),
                title: Text('Title',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('subtitle subtitle subtitle subtitle'),
                onTap: () {
                  //code to go to this notification
                },
              ),
            ),
          ),
          new Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white, style: BorderStyle.solid, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white),
            child: new Card(
              color: Colors.white,
              elevation: 2.0,
              child: new ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  maxRadius: 30,
//                  backgroundImage: AssetImage('assets/images/5.jpg'),
                ),
                title: Text('Title',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('subtitle subtitle subtitle subtitle'),
                onTap: () {
                  //code to go to this notification
                },
              ),
            ),
          ),
          new Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white, style: BorderStyle.solid, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white),
            child: new Card(
              color: Colors.white,
              elevation: 2.0,
              child: new ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  maxRadius: 30,
//                  backgroundImage: AssetImage('assets/images/5.jpg'),
                ),
                title: Text('Title',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('subtitle subtitle subtitle subtitle'),
                onTap: () {
                  //code to go to this notification
                },
              ),
            ),
          ),
          new Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white, style: BorderStyle.solid, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white),
            child: new Card(
              color: Colors.white,
              elevation: 2.0,
              child: new ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  maxRadius: 30,
//                  backgroundImage: AssetImage('assets/images/5.jpg'),
                ),
                title: Text('Title',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('subtitle subtitle subtitle subtitle'),
                onTap: () {
                  //code to go to this notification
                },
              ),
            ),
          ),
          new Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white, style: BorderStyle.solid, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white),
            child: new Card(
              color: Colors.white,
              elevation: 2.0,
              child: new ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  maxRadius: 30,
//                  backgroundImage: AssetImage('assets/images/5.jpg'),
                ),
                title: Text('Title',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('subtitle subtitle subtitle subtitle'),
                onTap: () {
                  //code to go to this notification
                },
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBarScreen(),
    );
  }
}
