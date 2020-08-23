import 'package:flutter/cupertino.dart';

class Report with ChangeNotifier {
  final String reportingUserID;
  final String reportingUserPostID;
  final String reportingUserPostImage;
  final String reportedPostID;
  final String reportedPostOwnerID;
  final String reportedPostImage;
  final int timeStamp;

  Report(
      {@required this.reportingUserID,
      @required this.reportingUserPostID,
      @required this.reportedPostID,
      @required this.reportedPostOwnerID,
      @required this.timeStamp,
      @required this.reportingUserPostImage,
      @required this.reportedPostImage});
}
