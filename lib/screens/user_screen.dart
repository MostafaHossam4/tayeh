import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayeh/model/user.dart';
import 'package:tayeh/provider/users.dart';
import 'package:tayeh/screens/home_screen.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

enum SingingCharacter { male, female }

class UserScreen extends StatefulWidget {
  static String routeName = '/userScreen';
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  SingingCharacter _gender = SingingCharacter.male;
  String _name;
  String _address;
  String _natoinalldImageUrl = '';
  String _natoinalld;
  String _userId;
  String fileType = 'image';
  File file;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;
  String result = '';
  String filePath = '';

  Future<void> _uploadFile(File file, String filename) async {
    ///group is where the `image` of the `child` will be stored
    try {
      StorageReference storageReference;
      if (fileType == 'image') {
        storageReference = FirebaseStorage.instance
            .ref()
            .child("national_id_images/$filename");
      }
      final StorageUploadTask uploadTask = storageReference.putFile(file);
      final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
      _natoinalldImageUrl = (await downloadUrl.ref.getDownloadURL());
      print("URL is $_natoinalldImageUrl");
      setState(() {
        file = file;
      });
    } catch (ex) {
      throw ex;
    }
  }

  Future filePicker(BuildContext context) async {
    try {
      if (fileType == 'image') {
        file = await FilePicker.getFile(type: FileType.IMAGE);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        setState(() {
          filePath = file.path;
        });
      } else {
        print('unknown file type');
      }
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  _showSnackbar(BuildContext cxt, String message) {
    final scaff = _scaffoldKey.currentState;
    scaff.showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.black,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? MediaQuery.of(context).size.width * 0.4
                            : MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? MediaQuery.of(context).size.height * 0.6
                            : MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: MediaQuery.of(context).orientation ==
                                        Orientation.landscape
                                    ? BoxFit.fitHeight
                                    : BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                                image: AssetImage("assets/images/logo2.png"))),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10.0,
                                  spreadRadius: 0,
                                  offset: Offset(-2.0, -2.0))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: <Widget>[

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'First Name',
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            )),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter First Name.';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _name = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Last Name',
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            )),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter Last Name.';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _name = _name + value;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Address',
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      )),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Address.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _address = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText: 'National Id',
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      )),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter NatoinalId.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _natoinalld = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 150,
                                      height: 100,
                                      margin: EdgeInsets.only(
                                        top: 8,
                                        right: 10,
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),

                                          ),
                                          image:DecorationImage(
                                            image:file == null

                                                ?  AssetImage(
                                                "assets/images/id.jpg")
                                                :FileImage(
                                              file,
                                            ),
                                          ),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 10.0,
                                                spreadRadius: 0,
                                                offset: Offset(-2.0, -2.0))
                                          ]),


                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      child: Container(
                                        color: Theme.of(context).buttonColor,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.image,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            filePicker(context);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              ///////////////////////////////////////Delete
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: TextFormField(
                              //     decoration: InputDecoration(
                              //         labelText: 'Upload Image',
                              //         labelStyle: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           color: Colors.grey,
                              //         )),
                              //   ),
                              // ),
                              ///////////////////////////////////////Delete
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: RadioListTile<SingingCharacter>(
                                          title: const Text('male'),
                                          value: SingingCharacter.male,
                                          groupValue: _gender,
                                          onChanged: (SingingCharacter value) {
                                            setState(() {
                                              _gender = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: RadioListTile<SingingCharacter>(
                                          title: const Text('female'),
                                          value: SingingCharacter.female,
                                          groupValue: _gender,
                                          onChanged: (SingingCharacter value) {
                                            setState(() {
                                              _gender = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await FirebaseAuth.instance
                                      .currentUser()
                                      .then((user) {
                                    _userId = user.uid;
                                  });

                                  if (_formKey.currentState.validate()) {
                                    if (file == null) {
                                      _showSnackbar(context,
                                          'Please upload your national ID image!');
                                    } else {
                                      _formKey.currentState.save();
                                      // If the form is valid
                                      try {
                                        await _uploadFile(file, fileName);

                                        var user = User(
                                            nationalIdImage:
                                                _natoinalldImageUrl,
                                            name: _name,
                                            address: _address,
                                            gender: _gender.toString(),
                                            nationalId: _natoinalld);
                                        try {
                                          await Provider.of<Users>(context,
                                                  listen: false)
                                              .createDataUser(_userId, user);
                                          Users.currentUser =
                                              await Provider.of<Users>(context,
                                                      listen: false)
                                                  .getUser(_userId);
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  HomeScreen.routName);
                                        } catch (e) {
                                          print(e);
                                        }
                                      } catch (exc) {
                                        print(exc);
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 30),
                                  width: MediaQuery.of(context).orientation ==
                                          Orientation.landscape
                                      ? MediaQuery.of(context).size.width * 0.85
                                      : MediaQuery.of(context).size.width * 0.9,
                                  height: MediaQuery.of(context).orientation ==
                                          Orientation.landscape
                                      ? MediaQuery.of(context).size.height *
                                          0.12
                                      : MediaQuery.of(context).size.height *
                                          0.06,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
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
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
