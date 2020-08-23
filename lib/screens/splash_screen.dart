import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayeh/provider/users.dart';
import 'package:tayeh/screens/home_screen.dart';
import 'package:tayeh/screens/signup_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  void start() {
    Timer(Duration(seconds: 5), () {
      _initData();
    });
  }
  String _userId;

  @override
  void initState() {
    start();
    super.initState();
  }
  _initData() async {
    await FirebaseAuth.instance.currentUser().then((user){
      user == null ? _userId = null:_userId = user.uid;
    });
    if (_userId != null) {
         Users.currentUser = await Provider.of<Users>(context,listen: false).getUser(_userId);
         Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
      // todo: navigate to main screen
    }else{
      // todo: else navigate to auth screen
      Navigator.of(context).pushReplacementNamed(SignUpScreen.routName);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                'assets/images/logo.png',
              ),
            )));
  }
}