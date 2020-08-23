import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tayeh/provider/users.dart';
import 'package:tayeh/screens/post_screen.dart';
import 'package:tayeh/widget/bottom_navigation_bar.dart';
import 'package:tayeh/widget/drawer.dart';
import 'package:tayeh/widget/filter_result_listview.dart';
import 'package:tayeh/widget/home_list_view.dart';
import '../widget/home_list_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum FilterOptions {
  Lost,
  Found,
}

class FilterResult extends StatefulWidget {
  static const routName = '/filterresult';

  @override
  _FilterResultState createState() => _FilterResultState();
}

class _FilterResultState extends State<FilterResult> {
  var isLost = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: Color(0xff16697a),
              ),
              onPressed: () => Navigator.of(context).pop()),
          title: Text(
            'Filter results',
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
//        leading: IconButton(
//          icon: Icon(Icons.menu, size: 30, color: Theme.of(context).primaryColor,),
//          onPressed: () {
//            _scaffoldKey.currentState.openDrawer();
//          },
//        ),
        ),
        drawer: DrawerScreen(),
        body: TabBarView(
          children: <Widget>[
            FilterResultListView(
              state: 'post_found',
            ),
          ],
        ),
      ),
    );
  }
}
