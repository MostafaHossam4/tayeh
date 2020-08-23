import 'package:flutter/cupertino.dart';

class Post with ChangeNotifier {
  final String age;
  final String idPost;
  final String description;
  final String gender;
  final String imageUrl;
  final String location;
  final String name;
  final bool public;
  final String time;
  final String ownerId;
  final String ownerName;
  bool isReported;
  final List<dynamic> encoding;
  final int timeStamp;

  Post({
    this.age,
    this.idPost,
    this.description,
    this.gender,
    this.imageUrl,
    this.location,
    this.name,
    this.public,
    this.time,
    this.ownerId,
    this.ownerName,
    this.encoding,
    @required this.timeStamp,
    @required this.isReported
  });
}
