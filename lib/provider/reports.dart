import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tayeh/model/report.dart';

class Reports with ChangeNotifier {
  final databaseReference = Firestore.instance;

  Future<void> createReport({Report report}) async {
    await databaseReference.collection('Reports').document().setData({
      'reported_post_ID': report.reportedPostID,
      'reported_post_owner_ID': report.reportedPostOwnerID,
      'reporting_user_ID': report.reportingUserID,
      'reporting_user_post_ID': report.reportingUserPostID,
      'timeStamp': DateTime.now().millisecondsSinceEpoch,
      'reporting_user_post_image': report.reportingUserPostImage,
      'reported_post_image': report.reportedPostImage
    }).catchError((error) {
      throw error;
    });
    await databaseReference
        .collection('post_lost')
        .document(report.reportingUserPostID)
        .updateData({'isReported': true});
    await databaseReference
        .collection('post_found')
        .document(report.reportedPostID)
        .updateData({'isReported': true});
  }
}
