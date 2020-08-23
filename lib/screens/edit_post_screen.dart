import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tayeh/model/post.dart';
import 'package:tayeh/provider/posts.dart';
import '../widget/adaptive_flat_button.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditPostScreen extends StatefulWidget {
  static const routeName = '/editpostscreen';

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

enum SingingCharacter { male, female }

class _EditPostScreenState extends State<EditPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _name;
  String _address;
  String _age;
  String message;
  DateTime _time;
  String _timeString;
  String _desc;
  SingingCharacter _gender;
  String _imageUrl = '';
  bool _isPublic;
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
  final _nameFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _ageFocusNode = FocusNode();
  final _describeFocusNode = FocusNode();
  bool isImageUpdated = false;
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
    await Provider.of<Posts>(context).deleteFileFromStorage(_imageUrl);
    _imageUrl = (await downloadUrl.ref.getDownloadURL());
    print("URL is $_imageUrl");
    try {
      setState(() {
        _imageUrl = _imageUrl;
      });
    } catch (Exception) {}
  }

  Future getImage() async {
    print('bodza');
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    try {
      setState(() {
        fileName = p.basename(image.path);
        print(fileName);
        file = image;
        isImageUpdated = true;
      });
    } catch (Ex) {}
  }

  Future filePicker(BuildContext context, bool group) async {
    try {
      if (fileType == 'image') {
        file = await FilePicker.getFile(type: FileType.IMAGE);
        print(fileName);
        setState(() {
          fileName = p.basename(file.path);
          file = file;
          isImageUpdated = true;
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

  void _presentDatePicker() {
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
  bool isLost;
  List<dynamic> state;
  Post post;
  bool ft = true;
  @override
  void didChangeDependencies() {
    if(ft) {
      state = ModalRoute
          .of(context)
          .settings
          .arguments;
      post = state[1];
      print('object 2 ' + post.idPost);
      if (state[0] == 'post_found') {
        isLost = false;
      } else {
        isLost = true;
      }
      setState(() {
        dropdownValue = post.age;
        _name = post.name;
        _age = post.age;
        _desc = post.description;
        _timeString = post.time;
        _address = post.location;
        if (post.gender == 'male')
          _gender = SingingCharacter.male;
        else
          _gender = SingingCharacter.female;

        _imageUrl = post.imageUrl;
        _isPublic = post.public;
        print('here' + _isPublic.toString());
      });
      ft = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Post',
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).buttonColor,
          actions: <Widget>[],
        ),
        key: _scaffoldKey,
        body: Builder(
          builder: (ctx) => Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          initialValue: post.name,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
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
                            FocusScope.of(context).requestFocus(_nameFocusNode);
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          initialValue: post.location,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(),
                          validator: (value) {
                            if (value.trim().length == 0) {
                              return 'Please Enter The Address.';
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
                        SizedBox(height: 10.0),
                        isLost
                            ? TextFormField(
                                initialValue: post.age,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(),
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
                                  FocusScope.of(context)
                                      .requestFocus(_ageFocusNode);
                                },
                              )
                            : DropdownButton<String>(
                                isExpanded: true,
                                value: dropdownValue,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 28,
                                elevation: 20,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                underline: Container(
                                  height: 3,
                                  color: Colors.grey,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    _age = newValue;
                                    dropdownValue = newValue;
                                  });
                                },
                                items: <String>[
                                  '0-5',
                                  '5-10',
                                  '10-15',
                                  'other'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                        TextFormField(
                          initialValue: post.description,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(),
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
                        Container(
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  _timeString == null
                                      ? 'No Date Chosen!'
                                      : 'Picked Date: ${_timeString.toString()}',
                                ),
                              ),
                              AdaptiveFlatButton(
                                'Choose Date',
                                _presentDatePicker,
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: RadioListTile<SingingCharacter>(
                                title: const Text('Male'),
                                value: SingingCharacter.male,
                                groupValue: _gender,
                                onChanged: (SingingCharacter value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: RadioListTile<SingingCharacter>(
                                title: const Text('Female'),
                                value: SingingCharacter.female,
                                groupValue: _gender,
                                onChanged: (SingingCharacter value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.image),
                                onPressed: () {
                                  setState(() {
                                    fileType = 'image';
                                    filePicker(context, isLost);
                                  });
                                }),
                            IconButton(
                                icon: Icon(Icons.camera_alt),
                                onPressed: () {
                                  setState(() {
                                    fileType = 'image';
                                    getImage();
                                  });
                                }),
                            Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.only(
                                  top: 8,
                                  right: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                child: file != null
                                    ? FittedBox(
                                        child: Image.file(
                                          file,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )
                                    : _imageUrl != null && _imageUrl.length > 5
                                        ? FittedBox(
                                            child: Image.network(
                                              _imageUrl,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          )
                                        : Text(
                                            'Choose image',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          )),
                            currentState == 'Uploading your image..' ||
                                    currentState ==
                                        'Uploading your post, Please wait'
                                ? CircularProgressIndicator(
                                    backgroundColor:
                                        Theme.of(context).buttonColor,
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Text('Public'),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Switch(
                                value: _isPublic,
                                onChanged: (value) {
                                  print('=>' + value.toString());

                                  setState(() {
                                    _isPublic = value;
                                  });
                                },
                                activeTrackColor: Theme.of(context).accentColor,
                                activeColor: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: currentState == 'Uploading your image..' ||
                                  currentState ==
                                      'Uploading your post, Please wait'
                              ? null
                              : () async {
                                  print('Pressed');
                                  await FirebaseAuth.instance
                                      .currentUser()
                                      .then((user) {
                                  });
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    if (_timeString != null) {
                                      if (_gender != null) {
                                        if (!isImageUpdated) {
                                          var post = Post(
                                              age: !isLost && _age == null
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
                                              time: _timeString);
                                          try {
                                            if (isLost) {                                              
                                              await Provider.of<Posts>(context)
                                                  .updatePost(this.post.idPost, post,
                                                      'post_lost')
                                                  .then((value) {
                                                _message =
                                                    'The post has been updated';
                                                _isReady = true;
                                                _showSnackbar(ctx);
                                              }).catchError((error) {
                                                _message = 'Please try again !';
                                                print(error.toString());
                                                _isReady = false;
                                                _showSnackbar(ctx);
                                              });
                                            } else {
                                              await Provider.of<Posts>(context)
                                                  .updatePost(this.post.idPost, post,
                                                      'post_found')
                                                  .then((value) async {
                                                _isReady = true;
                                                _message =
                                                    'The post has been updated';
                                                _showSnackbar(ctx);
                                              }).catchError((error) {
                                                _isReady = false;
                                                _message = 'Please try again !';
                                                print(error.toString());
                                                _showSnackbar(ctx);
                                              });
                                            }
                                          } catch (e) {
                                            print(e);
                                            setState(() {
                                              currentState = 'Done';
                                            });
                                            _message = 'Something went wrong!';
                                            _isReady = false;
                                            _showSnackbar(ctx);
                                          }
                                        } else {
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
                                                    age: !isLost && _age == null
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
                                                    time: _timeString);
                                                try {
                                                  if (isLost) {
                                                    await Provider.of<Posts>(
                                                            context)
                                                        .updatePost(this.post.idPost,
                                                            post, 'post_lost')
                                                        .then((value) {
                                                      _message =
                                                          'The post has been updated';
                                                      _isReady = true;
                                                      _showSnackbar(ctx);
                                                    }).catchError((error) {
                                                      _message =
                                                          'Please try again !';
                                                          print(error.toString());
                                                      _isReady = false;
                                                      _showSnackbar(ctx);
                                                    });
                                                  } else {
                                                    await Provider.of<Posts>(
                                                            context)
                                                        .updatePost(this.post.idPost,
                                                            post, 'post_found')
                                                        .then((value) async {
                                                      _isReady = true;
                                                      _message =
                                                          'The post has been updated';
                                                      _showSnackbar(ctx);
                                                    }).catchError((error) {
                                                      _isReady = false;
                                                      _message =
                                                          'Please try again !';
                                                          print(error.toString());
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
                                        }
                                      } else {
                                        _message = 'Please select the gender!';
                                        _isReady = false;
                                        _showSnackbar(ctx);
                                      }
                                    } else {
                                      _message = 'Please select the date!';
                                      _isReady = false;
                                      _showSnackbar(ctx);
                                    }
                                  }
                                },
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            width: MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? MediaQuery.of(context).size.width * 0.85
                                : MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? MediaQuery.of(context).size.height * 0.12
                                : MediaQuery.of(context).size.height * 0.06,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              color: currentState == 'Uploading your image..' ||
                                      currentState ==
                                          'Uploading your post, Please wait'
                                  ? Colors.grey[300]
                                  : Theme.of(context).buttonColor,
                            ),
                            child: Text('Update',
                                style: TextStyle(
                                    color: currentState ==
                                                'Uploading your image..' ||
                                            currentState ==
                                                'Uploading your post, Please wait'
                                        ? Colors.grey
                                        : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }
}
