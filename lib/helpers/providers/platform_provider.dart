import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlatformProvider extends ChangeNotifier{

  bool isIOS;

  PlatformProvider(this.isIOS);

  Future<void> changeplatform()async{
    isIOS = !isIOS;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isplatformIOS", isIOS);
    notifyListeners();
  }
}

