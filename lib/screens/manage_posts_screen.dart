import 'package:easy_localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:tayeh/widget/bottom_navigation_bar.dart';
import 'package:tayeh/widget/manage_posts_listview.dart';


class ManagePostsScreen extends StatefulWidget {
  static const routeName = '/managepostsscreen';
  @override
  _ManagePostsScreenState createState() => _ManagePostsScreenState();
}

class _ManagePostsScreenState extends State<ManagePostsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: new Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: Color(0xff16697a),
            ),
            onPressed: () => Navigator.of(context).pop()),

        bottom: TabBar(
          tabs: [
            Tab(text: Localization.instance.tr("FoundPosts"),),
            Tab(text: Localization.instance.tr("LostPosts"),),
          ],
          labelColor: Theme
              .of(context)
              .primaryColor,
        ),
        centerTitle: true,
        title: Text(
          Localization.instance.tr("ManagePosts"), style: TextStyle(color: Color(0xff16697a)),),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: TabBarView(
        children: <Widget>[
          ManagePostsListView(state: 'post_found',),
          ManagePostsListView(state: 'post_lost',),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarScreen(),
    ));
  }
}
