import 'package:flutter/material.dart';

class Counterprovider extends ChangeNotifier{
  int counter =0;

  void increment(){
    counter++;
    notifyListeners();
  }
}