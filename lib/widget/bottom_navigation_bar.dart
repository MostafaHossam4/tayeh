import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tayeh/provider/users.dart';
import 'package:tayeh/screens/chat_screen.dart';
import 'package:tayeh/screens/filter_screen.dart';
import 'package:tayeh/screens/home_screen.dart';
import 'package:tayeh/screens/menu_chat_admin.dart';
import 'package:tayeh/widget/home_list_view_design.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  @override
  _BottomNavigationBarScreenState createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) async {
    print('Selected index = [' +
        _selectedIndex.toString() +
        '] index = [' +
        index.toString() +
        ']');

    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      if (_selectedIndex == 0) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
        // Navigator.pushNamed(context, '/notificationscreen');
      } else if (_selectedIndex == 2) {
        if (Users.currentUser.data['admin']) {
          Navigator.of(context).pushReplacementNamed(MenuChatAdmin.routeName);
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chat(
                        peerId: "hYHaOORUREheKeADb3qjkyM51EC3",
                      )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
//        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff16697a),
        onTap: _onItemTapped,
        items: [
          new BottomNavigationBarItem(
            icon: const Icon(Icons.home, color: Color(0xff16697a), size: 27),
            title: new Text(
              Localization.instance.tr("Home"),
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff16697a)),
            ),
          ),
          new BottomNavigationBarItem(
            icon: const Icon(Icons.notifications,
                color: Color(0xff16697a), size: 27),
            title: new Text(
              Localization.instance.tr("Notifications"),
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff16697a)),
            ),
          ),
          new BottomNavigationBarItem(
            icon: const Icon(Icons.local_post_office,
                color: Color(0xff16697a), size: 27),
            title: new Text(
              Localization.instance.tr("Messages"),
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff16697a)),
            ),
          )
        ]);
  }
}
