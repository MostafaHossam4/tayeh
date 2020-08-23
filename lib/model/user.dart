

import 'package:flutter/cupertino.dart';

class User {
  final String name;
  final String address;
  final String nationalId;
  final String nationalIdImage;
  final String gender;
  final String uid;

  User(
      {@required this.name,
      @required this.address,
      @required this.nationalId,
      @required this.nationalIdImage,
      @required this.gender,
      this.uid
      });

}
