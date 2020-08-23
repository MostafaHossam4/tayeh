import 'package:flutter/material.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Colors.lightBlueAccent,
              ),
              onPressed: () => Navigator.pushNamed(context, '/')),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.4
                          : MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? BoxFit.fitWidth
                                  : BoxFit.fill,
                              alignment: Alignment.topCenter,
                              image: AssetImage("assets/images/2.jpg"))),
                    ),
                    Positioned(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/1.jpg"),
                      ),
                      left: 10,
                      bottom: 0,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Ahmed Magdy',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '@Ahmed_Magdy1997',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.width * 0.3
                          : MediaQuery.of(context).size.width * 0.45,
                    ),
                  ],
                ),
                Center(
                    child: Text(
                  "Studies Computer Science at Faculty of science \n                    Lives in Alexandria, Egypt",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey,
                    height: 0.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/profilescreen');
                        },
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/cli.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Ahmed Magdy',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    '@Ahmed_Magdy1997',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          height: 230,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? BoxFit.fitWidth
                                      : BoxFit.fill,
                                  alignment: Alignment.topCenter,
                                  image: AssetImage("assets/images/3.jpg"))),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/profilescreen');
                        },
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/cli.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Ahmed Magdy',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    '@Ahmed_Magdy1997',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          height: 230,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? BoxFit.fitWidth
                                      : BoxFit.fill,
                                  alignment: Alignment.topCenter,
                                  image: AssetImage("assets/images/11.jpg"))),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
