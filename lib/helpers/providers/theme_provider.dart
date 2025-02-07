import r'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isdark;

  ThemeProvider(this.isdark);

  Future<void>changetheme()async{
    isdark=!isdark;
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.setBool("isthemechanged", isdark);
    notifyListeners();
  }
}



