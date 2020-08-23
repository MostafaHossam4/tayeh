import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() {
  runApp(MenuScreen());
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Navigation drawer'),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/2.jpg'),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: CircleAvatar(
                            maxRadius: 40,
                            backgroundImage: AssetImage('assets/images/1.jpg'),
                          ),
                        ),
                        Center(
                          child: AutoSizeText(
                            'Ahmed Magdy .....',
                            maxLines: 1,
                            maxFontSize: 40,
                            minFontSize: 10,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        AutoSizeText(
                          '20178342723',
                          maxLines: 1,
                          maxFontSize: 20,
                          minFontSize: 10,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text('Profile'),
                leading: Icon(
                  Icons.account_circle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text('Orphanages'),
                leading: Icon(
                  Icons.child_care,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text('Police Station'),
                leading: Icon(Icons.account_balance),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.arrow_back),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
