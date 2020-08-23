import 'package:flutter/material.dart';
import 'package:tayeh/widget/report_list_view.dart';

class ReportsScreen extends StatefulWidget {
  static const routeName = '/reportsscreen';

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reports Page',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: ReportListView(),
    );
  }
}
