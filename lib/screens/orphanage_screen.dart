import 'package:flutter/material.dart';
import 'package:tayeh/widget/bottom_navigation_bar.dart';
import 'package:tayeh/widget/drawer.dart';

class OrphanageScreen extends StatefulWidget {
  @override
  _OrphanageScreenState createState() => _OrphanageScreenState();
}

class _OrphanageScreenState extends State<OrphanageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool follow = false;

  void Follow() {
    follow = !follow;

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Orphanages',
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
                title: Text('Orphanage Name',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('#73974'),
                trailing:                    InkWell(
                  onTap: () {
                    Follow();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.07
                        : MediaQuery.of(context).size.height * 0.1,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 80,
                        bottom: MediaQuery.of(context).size.height / 90),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: follow
                        ? Text("UnFollow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15))
                        : Text("Follow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                ),
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
                title: Text('Orphanage Name',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('#73974'),
                trailing:                    InkWell(
                  onTap: () {
                    Follow();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.07
                        : MediaQuery.of(context).size.height * 0.1,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 80,
                        bottom: MediaQuery.of(context).size.height / 90),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: follow
                        ? Text("UnFollow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15))
                        : Text("Follow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                ),
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
                title: Text('Orphanage Name',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('#73974'),
                trailing:                    InkWell(
                  onTap: () {
                    Follow();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.07
                        : MediaQuery.of(context).size.height * 0.1,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 80,
                        bottom: MediaQuery.of(context).size.height / 90),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: follow
                        ? Text("UnFollow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15))
                        : Text("Follow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                ),
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
                title: Text('Orphanage Name',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('#73974'),
                trailing:                    InkWell(
                  onTap: () {
                    Follow();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.07
                        : MediaQuery.of(context).size.height * 0.1,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 80,
                        bottom: MediaQuery.of(context).size.height / 90),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: follow
                        ? Text("UnFollow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15))
                        : Text("Follow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                ),
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
                title: Text('Orphanage Name',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('#73974'),
                trailing:                    InkWell(
                  onTap: () {
                    Follow();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.07
                        : MediaQuery.of(context).size.height * 0.1,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 80,
                        bottom: MediaQuery.of(context).size.height / 90),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: follow
                        ? Text("UnFollow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15))
                        : Text("Follow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                ),
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
                title: Text('Orphanage Name',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('#73974'),
                trailing:                    InkWell(
                  onTap: () {
                    Follow();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.07
                        : MediaQuery.of(context).size.height * 0.1,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 80,
                        bottom: MediaQuery.of(context).size.height / 90),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: follow
                        ? Text("UnFollow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15))
                        : Text("Follow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                ),
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
                title: Text('Orphanage Name',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('#73974'),
                trailing:                    InkWell(
                  onTap: () {
                    Follow();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.07
                        : MediaQuery.of(context).size.height * 0.1,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 80,
                        bottom: MediaQuery.of(context).size.height / 90),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: follow
                        ? Text("UnFollow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15))
                        : Text("Follow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                ),
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
                title: Text('Orphanage Name',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
                subtitle: Text('#73974'),
                trailing:                    InkWell(
                  onTap: () {
                    Follow();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.07
                        : MediaQuery.of(context).size.height * 0.1,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 80,
                        bottom: MediaQuery.of(context).size.height / 90),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: follow
                        ? Text("UnFollow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15))
                        : Text("Follow",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                ),
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


