import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tayeh/provider/users.dart';
import 'package:tayeh/screens/manage_posts_screen.dart';
import 'package:tayeh/screens/reports_screen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  Widget popUp(var data) {
    return CupertinoActionSheet(
      title: new Text(Localization.instance.tr("Language")),
      message: new Text(Localization.instance.tr("Chooseyourlanguage")),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: new Text(Localization.instance.tr("English")),
          onPressed: () {
            this.setState(() {
              data.changeLocale(locale: Locale("en", "US"));
              print(Localizations.localeOf(context).languageCode);
            });
            Navigator.of(context).pop();
          },
        ),
        CupertinoActionSheetAction(
          child: new Text(Localization.instance.tr("arabic")),
          onPressed: () {
            this.setState(() {
              data.changeLocale(locale: Locale("ar", "DZ"));
              print(Localizations.localeOf(context).languageCode);
            });
            Navigator.of(context).pop();
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: new Text(Localization.instance.tr("Cancel")),
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff16697a),
            ),
            accountName: Text(Users.currentUser.data['name']),
            accountEmail: Text(Users.currentUser.data['national_id']),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: double.infinity,
              backgroundImage: AssetImage("assets/images/avatar.jpg"),
            ),
          ),
          !Users.currentUser.data['admin'] ? ListTile(
            title: Text(Localization.instance.tr("ManagePosts")),
            leading: Icon(Icons.description),
            onTap: () {
              Navigator.of(context).pushNamed(ManagePostsScreen.routeName);
            },
          ) : SizedBox(),
          !Users.currentUser.data['admin']  ? Divider() : SizedBox(),
          Users.currentUser.data['admin']  ? ListTile(
            title: Text('Reports'),
            leading: Icon(Icons.report),
            onTap: () {
              Navigator.of(context).pushNamed(ReportsScreen.routeName);
            },
          ):  SizedBox(),
          Users.currentUser.data['admin']  ? Divider() : SizedBox(),
          ListTile(
            title: Text(Localization.instance.tr("Language")),
            leading: Icon(Icons.language),
            onTap: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => popUp(data));
            },
          ),
        ],
      ),
    );
  }
}
