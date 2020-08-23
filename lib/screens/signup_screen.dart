import 'package:easy_localization/localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayeh/provider/users.dart';
import 'package:tayeh/screens/user_screen.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routName = 'signupscreen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  String _smsCode = '';
  String _error = '';
  String _verificationId = '';
  String _phoneNumber = '';
  String _userId;

  @override
  void initState() {
    super.initState();
    //   _initVerifyCall();
  }

  // TODO: After user enteres the phone number.
  _initVerifyCall() async {
    try {
      final PhoneVerificationCompleted verificationCompleted =
          (AuthCredential phoneAuthCredential) async {
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
        print('PhoneVerificationCompleted');
        _handleAfterVerification();
      };

      final PhoneVerificationFailed verificationFailed =
          (AuthException authException) {
        print('PhoneVerificationFailed' + authException.message);
        throw authException;
      };

      final PhoneCodeSent codeSent =
          (String verificationId, [int forceResendingToken]) async {
        print('PhoneCodeSent');
        _verificationId = verificationId;
      };

      final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
          (String verificationId) {
        print('PhoneCodeAutoRetrievalTimeout');
        _verificationId = verificationId;
      };

      // We're Supporting Only Egypt for Now! +20
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+2${this._phoneNumber}", // TODO: Phone Number
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } on PlatformException catch (e) {
      _error = e.message;
      _displaySnackBar(context, _error);
    } on AuthException catch (e) {
      _error = e.message;
      _displaySnackBar(context, _error);
    } on SocketException catch (e) {
      _error = e.message;
      _displaySnackBar(context, _error);
    } catch (e) {
      _error = e.toString();
      _displaySnackBar(context, _error);
    } finally {
      // rebuild state if exist;
      if (mounted) setState(() {});
    }
  }

  // TODO: After users enters the code.
  _confirm(BuildContext context) async {
    try {
      if (_verificationId.isEmpty) {
        _error = 'Message not sent';
        _displaySnackBar(context, _error);
        if (mounted) setState(() {});
      } else if (_smsCode.length != 6) {
        _error = 'code length not correct';
        _displaySnackBar(context, _error);
        if (mounted) setState(() {});
      } else {
        if (mounted) setState(() => _error = '');
        await signInWithPhoneNumber(
            _smsCode, _verificationId); // TODO NEW FUNCTION
        _handleAfterVerification();
      }
    } on PlatformException catch (e) {
      _error = e.message;
      _displaySnackBar(context, _error);
    } on AuthException catch (e) {
      _error = e.message;
      _displaySnackBar(context, _error);
    } on SocketException catch (e) {
      _error = e.message;
      _displaySnackBar(context, _error);
    } catch (e) {
      _error = e.toString();
      _displaySnackBar(context, _error);
    } finally {
      // rebuild state if exist;
      if (mounted) setState(() {});
    }
  }

  _handleAfterVerification() async {
    //todo :  Navigate to next page
    await FirebaseAuth.instance.currentUser().then((user) {
      _userId = user.uid;
    });
    Users.currentUser =
        await Provider.of<Users>(context, listen: false).getUser(_userId);
      
    if (Users.currentUser != null) {
      if(Users.currentUser['admin'])
        print("admin");
      else
        Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
    } else
      Navigator.of(context).pushReplacementNamed(UserScreen.routeName);
  }

  Future<FirebaseUser> signInWithPhoneNumber(
      String smsCode, String verificationId) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final FirebaseUser user =
        (await FirebaseAuth.instance.signInWithCredential(credential));
    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    assert(user.uid == currentUser.uid);
    return user;
  }

  //End Code Saif

  @override
  Widget build(BuildContext context) {
//    Auth auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
        backgroundColor: Color.fromRGBO(246, 246, 251, 1),
        key: _scaffoldKey,
        body: SafeArea(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? MediaQuery.of(context).size.width * 0.4
                          : MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? MediaQuery.of(context).size.height * 0.6
                          : MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? BoxFit.fitHeight
                            : BoxFit.fitWidth,
                        alignment: Alignment.center,
                        image: AssetImage("assets/images/logo2.png"),
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  cursorColor: Theme.of(context).buttonColor,
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.phone_android,
                                      color: Colors.black,
                                      size: 17,
                                    ),
                                    labelText: Localization.instance.tr("Mobilenumber"),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      )
                                  ),
                                  onChanged: (value) {
                                    this._phoneNumber = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              RaisedButton(
                                onPressed: () {
                                  print(this._phoneNumber);
                                  _initVerifyCall();
                                },
                                padding: const EdgeInsets.all(7.0),
                                focusColor: Theme.of(context).accentColor,
                                textColor: Colors.white,

                                color: Theme.of(context).buttonColor,
                                child: Text(Localization.instance.tr("Sent"),
                                    style: TextStyle(fontSize: 15)),
                                elevation: 1.0,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.sms,
                                size: 17,
                              ),
                              labelText: Localization.instance.tr("Code"),
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                )
                            ),
                            onChanged: (value) {
                              this._smsCode = value;
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            child: InkWell(
                              onTap: () {
                                print(this._smsCode);
                                _confirm(context);
                              },
                              child: Container(
                                width: double.infinity,
                                height: 40,
                                child: Center(
                                  child: Text(Localization.instance.tr("Next"),
                                      style: Theme.of(context).textTheme.button),
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).buttonColor,
//                            border: Border.all(
//                              color: Theme.of(context).primaryColor,
//                            ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
