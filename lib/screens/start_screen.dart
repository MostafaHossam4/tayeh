import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  static const routName = '/StartScreen';
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).orientation == Orientation.landscape
                ? MediaQuery.of(context).size.width * 1
                : MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).orientation == Orientation.landscape
                ? MediaQuery.of(context).size.height * 1.2
                : MediaQuery.of(context).size.height * 0.8,
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).padding.top + 20
                        : 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 35.0),
                  child: Container(
                    width: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? MediaQuery.of(context).size.width * 0.6
                        : MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? MediaQuery.of(context).size.height * 0.6
                        : MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? BoxFit.fitHeight
                                : BoxFit.fill,
                            alignment: Alignment.topCenter,
                            image: AssetImage("assets/images/logo2.png"))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).padding.top + 0
                        : 0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/loginscreen');
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    width: MediaQuery.of(context).orientation ==
                        Orientation.landscape
                        ? MediaQuery.of(context).size.width * 0.85
                        : MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).orientation ==
                        Orientation.landscape
                        ? MediaQuery.of(context).size.height * 0.12
                        : MediaQuery.of(context).size.height * 0.06,
//                        margin: EdgeInsets.only(top: 40),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Color(0xff16697a),
                    ),
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/regestrationscreen');
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).orientation ==
                        Orientation.landscape
                        ? MediaQuery.of(context).size.width * 0.85
                        : MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).orientation ==
                        Orientation.landscape
                        ? MediaQuery.of(context).size.height * 0.12
                        : MediaQuery.of(context).size.height * 0.06,
//                        margin: EdgeInsets.only(top: 40),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Color(0xff16697a),
                    ),
                    child: Text('Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
