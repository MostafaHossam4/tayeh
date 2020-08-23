import 'dart:async';
import 'dart:io';

import 'package:easy_localization/localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:tayeh/model/post.dart';
import 'package:tayeh/provider/posts.dart';

class PostScreen extends StatefulWidget {
  static const routeName = '/postscreen';

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _name;
  String _address;
  String _age;
  String message;
  DateTime _time;
  String _timeString;
  String _desc;
  String _gender;
  String _imageUrl = '';
  bool _isPublic = true;
  var val;
  String _message;
  bool _isReady =
      false; //true if the post is ready to be published, false if not
  String fileType = '';
  File file;
  String fileName = '';
  String operationText = '';
  String currentState = ''; //Shows the user where he is like loading spinner
  String result = '';
  List<dynamic> _encoding = [1, 2, 3, 4, 5]; //TODO add image encoding here
  final _nameFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _ageFocusNode = FocusNode();
  final _describeFocusNode = FocusNode();

  Future<void> _uploadFile(File file, String filename, bool group) async {
    ///group is where the `image` of the `child` will be stored
    StorageReference storageReference;
    if (fileType == 'image') {
      if (group) {
        storageReference =
            FirebaseStorage.instance.ref().child("lost-images/$filename");
      } else {
        storageReference =
            FirebaseStorage.instance.ref().child("found-images/$filename");
      }
    }
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    _imageUrl = (await downloadUrl.ref.getDownloadURL());
    print("URL is $_imageUrl");
    try {
      setState(() {
        _imageUrl = _imageUrl;
      });
    } catch (Exception) {}
  }

  Future getImage(BuildContext context) async {
    print('bodza');
    unfocusAll();
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
    final faceDetector = FirebaseVision.instance.faceDetector();
    final List<Face> faces = await faceDetector.processImage(visionImage);
    print('Number of faces = ' + faces.length.toString());
    if (faces.length > 1) {
      setState(() {
        file = null;
        _message = 'Please select an image with one face only';
        _showSnackbar(context);
      });
    } else if (faces.length < 1) {
      setState(() {
        file = null;
        _message = 'Image must contain a face';
        _showSnackbar(context);
      });
    } else {
      try {
        setState(() {
          fileName = p.basename(image.path);
          print(fileName);
          file = image;
        });
      } catch (Ex) {}
    }
  }

  unfocusAll() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  Future filePicker(BuildContext context, bool group) async {
    unfocusAll();
    try {
      if (fileType == 'image') {
        file = await FilePicker.getFile(type: FileType.IMAGE);
        final FirebaseVisionImage visionImage =
            FirebaseVisionImage.fromFile(file);
        final faceDetector = FirebaseVision.instance.faceDetector();
        final List<Face> faces = await faceDetector.processImage(visionImage);
        print('Now am here = ' + faces.toString());
        print('Number of faces' + faces.length.toString());
        if (faces.length > 1) {
          setState(() {
            file = null;
            _message = 'Please select an image with one face only';
            _showSnackbar(context);
          });
        } else if (faces.length < 1) {
          setState(() {
            file = null;
            _message = 'Image must contain a face';
            _showSnackbar(context);
          });
        } else {
          setState(() {
            fileName = p.basename(file.path);
            file = file;
          });
        }
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

  void _presentDatePicker() {
    unfocusAll();
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _time = pickedDate;
        _timeString = _time.toString().split(' ').first;
      });
    });
  }

  void somthing(bool e) {
    setState(() {
      if (e) {
        message = "Public";
        val = e;
      } else {
        message = "Private";
        val = e;
      }
    });
  }

  _showSnackbar(BuildContext cxt) {
    final scaff = Scaffold.of(cxt);
    scaff.showSnackBar(SnackBar(
      content: Text(_message),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.black,
    ));
    Future.delayed(Duration(seconds: 3)).then((_) {
      if (_isReady) Navigator.pop(context);
    });
  }

  String dropdownValue = '0-5';
  String dropdownValue2 = 'Male';
  String dropdownValue3 = '';
  String _userId;

  @override
  Widget build(BuildContext context) {
    var isLost = ModalRoute.of(context).settings.arguments as bool;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: Color(0xff16697a),
              ),
              onPressed: () => Navigator.of(context).pop()),
          title: Text(
            'Post',
            style: TextStyle(color: Color(0xff16697a)),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: <Widget>[],
        ),
        key: _scaffoldKey,
        body: Builder(
          builder: (ctx) => Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            backgroundImage: file == null
                                ? new ExactAssetImage(
                                    "assets/images/avatar.jpg")
                                : FileImage(
                                    file,
                                  ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Container(
                                  width: MediaQuery.of(context).size.width -
                                      (15 + 100 + 40),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .accentColor)),
                                      hintText: Localization.instance.tr("Name"),
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 13),
                                    ),
                                    validator: (value) {
                                      if (value.trim().length == 0) {
                                        return 'Please Enter child Name.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _name = value;
                                    },
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_nameFocusNode);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.0),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                child: Container(
                                  width: 120,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        IconButton(
                                            icon: Icon(
                                              Icons.image,
                                              size: 25,
                                            ),
                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                fileType = 'image';
                                                filePicker(ctx, isLost);
                                              });
                                            }),
                                        Container(
                                          width: 1,
                                          height: 45,
                                          color: Colors.grey[200],
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.camera_alt,
                                              size: 25,
                                            ),
                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                fileType = 'image';
                                                getImage(ctx);
                                              });
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
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
                          padding: const EdgeInsets.all(27.0),
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Text(
                                  Localization.instance.tr("MoreDetails"),
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: Localization.instance.tr("Location"),
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400], fontSize: 15),
                                ),
                                validator: (value) {
                                  if (value.trim().length == 0) {
                                    return 'Please Enter The Location.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _address = value;
                                },
                                focusNode: _nameFocusNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_addressFocusNode);
                                },
                              ),
                              SizedBox(height: 20.0),
                              isLost
                                  ? TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: Localization.instance.tr("Age"),
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 15),
                                      ),
                                      validator: (value) {
                                        if (value.trim().length == 0) {
                                          return 'Please Enter child Age .';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _age = value;
                                      },
                                      focusNode: _addressFocusNode,
                                      onFieldSubmitted: (_) {
//                                        FocusScope.of(context)
//                                            .requestFocus(_ageFocusNode);
                                        unfocusAll();
                                      },
                                    )
                                  : GestureDetector(
                                      onTap: unfocusAll,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: dropdownValue,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 28,
                                        elevation: 20,
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                        underline: Container(
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _age = newValue;
                                            dropdownValue = newValue;
                                            unfocusAll();
                                          });
                                        },
                                        items: <String>[
                                          '0-5',
                                          '5-10',
                                          '10-15',
                                          'other'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                              Container(
                                height: 80,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        _time == null
                                            ? Localization.instance.tr("Pleaseselectdate")
                                            : 'Picked Date: ${_timeString.toString()}',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                    // AdaptiveFlatButton(
                                    //   'Choose Date',
                                    //   _presentDatePicker,
                                    // )
                                    FlatButton(
                                      onPressed: _presentDatePicker,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          bottom:
                                              1, // space between underline and text
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                          color: Colors.grey[400],
                                          // Text colour here
                                          width: 1, // Underline width
                                        ))),
                                        child: Text(
                                          'Choose Date',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            // decoration: TextDecoration.underline,
                                            // decorationStyle: TextDecorationStyle.solid,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      color: Theme.of(context).primaryColor,
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          (27 + 10),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: GestureDetector(
                                          onTap: unfocusAll,
                                          child: DropdownButton<String>(
                                            iconEnabledColor: Colors.white,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 24,
                                            isExpanded: true,
                                            elevation: 16,
                                            hint: _gender == null
                                                ? Text(
                                              Localization.instance.tr("Gender"),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                : Text(
                                                    _gender,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                            style:
                                                TextStyle(color: Colors.black),
                                            underline: Container(
                                              height: 0,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                dropdownValue2 = newValue;
                                                _gender = newValue;
                                                unfocusAll();
                                              });
                                            },
                                            items: <String>[
                                              'Male',
                                              'Female',
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      color: Colors.grey[300],
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          (27 + 10),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: GestureDetector(
                                          onTap: unfocusAll,
                                          child: DropdownButton<String>(
                                            iconEnabledColor:
                                                Theme.of(context).primaryColor,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 24,
                                            elevation: 16,
                                            isExpanded: true,
                                            hint: _isPublic == null
                                                ? Text(
                                                    'Status',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  )
                                                : Text(
                                                    _isPublic
                                                        ? 'Public'
                                                        : 'Private',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            underline: Container(
                                              height: 0,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                dropdownValue3 = newValue;
                                                newValue == 'Public'
                                                    ? _isPublic = true
                                                    : _isPublic = false;
                                                unfocusAll();
                                              });
                                            },
                                            items: <String>[
                                              'Public',
                                              'Private',
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                      borderSide: new BorderSide(
                                        color: Colors.black,
                                        width: 0.2,
                                      ),
                                    ),
                                    hintText: Localization.instance.tr("Description"),
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400], fontSize: 15),
                                  ),
                                  focusNode: _ageFocusNode,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_describeFocusNode);
                                  },
                                  maxLines: 3,
                                  validator: (value) {
                                    if (value.trim().length == 0) {
                                      return 'Please Enter The Description.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _desc = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              GestureDetector(
                                onTap: currentState ==
                                            'Uploading your image..' ||
                                        currentState ==
                                            'Uploading your post, Please wait'
                                    ? null
                                    : () async {
                                        print('Pressed');
                                        unfocusAll();
                                        await FirebaseAuth.instance
                                            .currentUser()
                                            .then((user) {
                                          _userId = user.uid;
                                        });
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          if (_time != null) {
                                            if (_gender != null) {
                                              if (file != null) {
                                                try {
                                                  setState(() {
                                                    currentState =
                                                        'Uploading your image..';
                                                  });
                                                  await _uploadFile(
                                                      file, fileName, isLost);
                                                  setState(() {
                                                    currentState =
                                                        'Uploading your post, Please wait';
                                                  });
                                                  if (_imageUrl != '' &&
                                                      _imageUrl != null) {
                                                    var post = Post(
                                                      age: !isLost &&
                                                              _age == null
                                                          ? _age = '0-5'
                                                          : _age,
                                                      description: _desc,
                                                      gender: _gender
                                                          .toString()
                                                          .split('.')
                                                          .last,
                                                      imageUrl: _imageUrl,
                                                      location: _address,
                                                      name: _name,
                                                      public: _isPublic,
                                                      time: _timeString,
                                                      encoding: _encoding,
                                                      timeStamp: new DateTime
                                                              .now()
                                                          .millisecondsSinceEpoch,
                                                    );
                                                    try {
                                                      if (isLost) {
                                                        await Provider.of<
                                                                Posts>(context)
                                                            .createPost(
                                                                _userId,
                                                                post,
                                                                'post_lost')
                                                            .then((value) {
                                                          _message =
                                                              'The post has been published';
                                                          _isReady = true;
                                                          _showSnackbar(ctx);
                                                        }).catchError((error) {
                                                          _message =
                                                              'Please try again !';
                                                          _isReady = false;
                                                          _showSnackbar(ctx);
                                                        });
                                                      } else {
                                                        await Provider.of<
                                                                Posts>(context)
                                                            .createPost(
                                                                _userId,
                                                                post,
                                                                'post_found')
                                                            .then(
                                                                (value) async {
                                                          _isReady = true;
                                                          _message =
                                                              'The post has been published';
                                                          _showSnackbar(ctx);
                                                        }).catchError((error) {
                                                          _isReady = false;
                                                          _message =
                                                              'Please try again !';
                                                          _showSnackbar(ctx);
                                                        });
                                                      }
                                                    } catch (e) {
                                                      print(e);
                                                      setState(() {
                                                        currentState = 'Done';
                                                      });
                                                      _message =
                                                          'Something went wrong!';
                                                      _isReady = false;
                                                      _showSnackbar(ctx);
                                                    }
                                                  } else {
                                                    _message =
                                                        'Please upload an image for the child!';
                                                    _isReady = false;
                                                    _showSnackbar(ctx);
                                                  }
                                                } catch (Ex) {
                                                  print(Ex.toString());
                                                }
                                              } else {
                                                _message =
                                                    'Please upload an image for the child!';
                                                _isReady = false;
                                                _showSnackbar(ctx);
                                              }
                                            } else {
                                              _message =
                                                  'Please select the gender!';
                                              _isReady = false;
                                              _showSnackbar(ctx);
                                            }
                                          } else {
                                            _message =
                                                'Please select the date!';
                                            _isReady = false;
                                            _showSnackbar(ctx);
                                          }
                                        }
                                      },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    color: currentState ==
                                                'Uploading your image..' ||
                                            currentState ==
                                                'Uploading your post, Please wait'
                                        ? Colors.grey[300]
                                        : Theme.of(context).primaryColor,
                                  ),
                                  child: Center(
                                    child: Text(Localization.instance.tr("Publishpost"),
                                        style: TextStyle(
                                            color: currentState ==
                                                        'Uploading your image..' ||
                                                    currentState ==
                                                        'Uploading your post, Please wait'
                                                ? Colors.grey
                                                : Colors.white,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ));
  }
}
