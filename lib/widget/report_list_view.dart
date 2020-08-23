import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayeh/model/report.dart';
import 'package:tayeh/widget/report_list_view_design.dart';

class ReportListView extends StatefulWidget {
  @override
  _ReportListViewState createState() => _ReportListViewState();
}

class _ReportListViewState extends State<ReportListView> {

  @override
  Widget build(BuildContext context) {
    final databaseReference = Firestore.instance;
    final List<Report> allReports = [];
    return StreamBuilder<QuerySnapshot>(
        stream: databaseReference.collection('Reports').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ));
          }
          final reports = snapshot.data.documents;
          allReports.clear();
          for (var report in reports) {


            allReports.add(Report(
                reportedPostID: report.data['reported_post_ID'].toString(),
                reportedPostOwnerID:
                    report.data['reported_post_owner_ID'].toString(),
                reportingUserID: report.data['reporting_user_ID'].toString(),
                reportingUserPostID:
                    report.data['reporting_user_post_ID'].toString(),
                timeStamp: report.data['timeStamp'],
              reportingUserPostImage: report.data['reporting_user_post_image'],
              reportedPostImage: report.data['reported_post_image']
            )
            );
            allReports.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
          }
          if (allReports.length == 0) {
            return Center(child: Text('There are no reports yet!'));
          }
          return Container(
            child: ListView.builder(
              addAutomaticKeepAlives: true,
              cacheExtent: 9999999,
              scrollDirection: Axis.vertical,
              itemCount: allReports.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: allReports[i],
                child: ReportListViewDesgin(),
              ),
            ),
          );
        });
  }
}
