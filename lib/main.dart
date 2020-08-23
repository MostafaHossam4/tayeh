import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tayeh/provider/posts.dart';
import 'package:tayeh/provider/reports.dart';
import 'package:tayeh/provider/users.dart';
import 'package:tayeh/screens/chat_screen.dart';
import 'package:tayeh/screens/edit_post_screen.dart';
import 'package:tayeh/screens/filter_result_screen.dart';
import 'package:tayeh/screens/filter_screen.dart';
import 'package:tayeh/screens/home_screen.dart';
import 'package:tayeh/screens/manage_posts_screen.dart';
import 'package:tayeh/screens/menu_chat_admin.dart';
import 'package:tayeh/screens/menu_screen.dart';
import 'package:tayeh/screens/my_profile_screen.dart';
import 'package:tayeh/screens/orphanage_screen.dart';
import 'package:tayeh/screens/post_screen.dart';
import 'package:tayeh/screens/profile_screen.dart';
import 'package:tayeh/screens/reports_screen.dart';
import 'package:tayeh/screens/signup_screen.dart';
import 'package:tayeh/screens/similar_posts_screen.dart';
import 'package:tayeh/screens/splash_screen.dart';
import 'package:tayeh/screens/start_screen.dart';
import 'package:tayeh/screens/notification_screen.dart';
import 'package:tayeh/screens/user_screen.dart';

import 'model/report.dart';
import 'widget/image_to_full_screen.dart';

void main() => runApp(EasyLocalization(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: Users()),
            ChangeNotifierProvider.value(value: Posts()),
            ChangeNotifierProvider.value(value: Reports()),
            ChangeNotifierProvider.value(value: Report()),
          ],
          child: MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              //app-specific localization
              EasyLocalizationDelegate(
                  locale: data.locale, path: 'assets/lang'),
            ],
            supportedLocales: [Locale('en', 'US'), Locale('ar', 'DZ')],
            locale: data.locale,
            home: SplashScreen(),
            theme: ThemeData(
              // primaryColor: Color(0xff16697a),
              //  Color.fromRGBO(14, 11, 65, 1)
              primaryColor: Color(0xff16697a),
              appBarTheme: AppBarTheme(color: Colors.white),
              buttonColor: Color(0xff16697a),
              accentColor: Color(0xff82c0cc),
              textTheme: ThemeData.light().textTheme.copyWith(
                    button: TextStyle(fontSize: 18, color: Colors.white),
                  ),
//              iconTheme: IconThemeData(
//              color: Color(0xff16697a)
//          )
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              HomeScreen.routName: (context) => HomeScreen(),
              '/MyApp': (context) => MyApp(),
              '/myprofilescreen': (context) => MyProfileScreen(),
              '/profilescreen': (context) => ProfileScreen(),
              SignUpScreen.routName: (context) => SignUpScreen(),
              '/chatscreen': (context) => Chat(),
              StartScreen.routName: (context) => StartScreen(),
              UserScreen.routeName: (context) => UserScreen(),
              '/notificationscreen': (context) => NotificationScreen(),
              '/menuscreen': (context) => MenuScreen(),
              '/orphanagescreen': (context) => OrphanageScreen(),
              '/splashscreen': (context) => SplashScreen(),
              PostScreen.routeName: (context) => PostScreen(),
              ManagePostsScreen.routeName: (context) => ManagePostsScreen(),
              EditPostScreen.routeName: (context) => EditPostScreen(),
              MenuChatAdmin.routeName: (context) => MenuChatAdmin(),
              FilterScreen.routName: (context) => FilterScreen(),
              SimilarPostsScreen.routeName: (context) => SimilarPostsScreen(),
              FilterResult.routName: (context) => FilterResult(),
              ReportsScreen.routeName: (context) => ReportsScreen(),
              ImageToFullScreen.routeName: (context) => ImageToFullScreen(),
            },
          )),
    );
  }
}
