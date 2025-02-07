import 'package:contact_dairy_app/helpers/providers/contact_provider.dart';
import 'package:contact_dairy_app/helpers/providers/platform_provider.dart';
import 'package:contact_dairy_app/helpers/providers/theme_provider.dart';
import 'package:contact_dairy_app/views/screens/add_contactpage.dart';
import 'package:contact_dairy_app/views/screens/detail_page.dart';
import 'package:contact_dairy_app/views/screens/hidden_contact_page.dart';
import 'package:contact_dairy_app/views/screens/home_page.dart';
import 'package:contact_dairy_app/views/screens/intro_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences pref = await SharedPreferences.getInstance();

  bool isvisited = pref.getBool('isintroscreenvisited') ?? false;

  bool isvisitedchanged = pref.getBool("isthemechanged") ?? true;

  bool isplatformIOS = pref.getBool("isplatformchanged") ?? false;

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ThemeProvider(isvisitedchanged)),
        ChangeNotifierProvider(
            create: (context) => PlatformProvider(isplatformIOS)),
        ChangeNotifierProvider(create: (context) => ContactProvider()),
      ],
      builder: (context, _) {
        return (Provider.of<PlatformProvider>(context, listen: false).isIOS ==
                false)
            ? MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    textTheme: TextTheme(
                        displayLarge: TextStyle(color: Colors.green))),
                darkTheme: ThemeData.dark(),
                themeMode: (Provider.of<ThemeProvider>(context).isdark
                    ? ThemeMode.dark
                    : ThemeMode.light),
                initialRoute: (isvisited == false) ? 'intro_screen_page' : '/',
                routes: {
                  '/': (context) => HomePage(),
                  'add_contact_page': (context) => AddContactPage(),
                  'intro_screen_page': (context) => IntroScreen(),
                  'detail_screen_page': (context) => Detailcontactpage(),
                  'hidden_contact_page': (context) => HiddenContactPage(),
                },
              )
            : CupertinoApp(
                debugShowCheckedModeBanner: false,
                theme: CupertinoThemeData(
                  brightness: Provider.of<ThemeProvider>(context).isdark
                      ? Brightness.dark
                      : Brightness.light,
                ),
                initialRoute: (isvisited == false) ? 'intro_screen_page' : '/',
                routes: {
                  '/': (context) => HomePage(),
                  'add_contact_page': (context) => AddContactPage(),
                  'intro_screen_page': (context) => IntroScreen(),
                  'detail_screen_page': (context) => Detailcontactpage(),
                  'hidden_contact_page': (context) => HiddenContactPage(),
                },
              );
      }));
}
