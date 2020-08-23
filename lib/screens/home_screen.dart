import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tayeh/provider/users.dart';
import 'package:tayeh/screens/post_screen.dart';
import 'package:tayeh/widget/bottom_navigation_bar.dart';
import 'package:tayeh/widget/drawer.dart';
import 'package:tayeh/widget/home_list_view.dart';
import '../widget/home_list_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum FilterOptions {
  Lost,
  Found,
}

class HomeScreen extends StatefulWidget {
  static const routName = '/homescreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLost = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        bottom:  TabBar(
          tabs: [
            Tab(text: Localization.instance.tr("FoundPosts"),),
            Tab(text: Localization.instance.tr("LostPosts"),),
          ],
          labelColor: Theme.of(context).primaryColor,

        ),
        title: Text(
          Localization.instance.tr("Tayeh"),
          style: TextStyle(color: Theme.of(context).primaryColor,fontFamily: 'pacifico',fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.menu, size: 30, color: Theme.of(context).primaryColor,),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        actions: <Widget>[
          !Users.currentUser.data['admin'] ? PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Lost) {
                  isLost = true;
                  Navigator.of(context)
                      .pushNamed(PostScreen.routeName, arguments: isLost);
                } else {
                  isLost = false;
                  Navigator.of(context)
                      .pushNamed(PostScreen.routeName, arguments: isLost);
                }
              });
            },
            icon: Icon(FontAwesomeIcons.edit,color: Theme.of(context).primaryColor,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(Localization.instance.tr("LostPosts")),
                value: FilterOptions.Lost,
              ),
              PopupMenuItem(
                child: Text(Localization.instance.tr("FoundPosts")),
                value: FilterOptions.Found,
              ),
            ],
          ):SizedBox(),
        ],
      ),
      drawer: DrawerScreen(),
      body: TabBarView(
        children: <Widget>[
          HomeListView(state: 'post_found',),
          HomeListView(state: 'post_lost',),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarScreen(),
    ),);
  }
}
