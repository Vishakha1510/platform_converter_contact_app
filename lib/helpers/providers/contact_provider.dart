import 'package:flutter/cupertino.dart';

import '../../models/contact_model.dart';

class ContactProvider extends ChangeNotifier{
  List allcontact=[];

  List hiddencontacts=[];


  void addcontact({required Contact data}){
    allcontact.add(data);
    notifyListeners();
  }

  void deletecontact({required Contact data}){
    allcontact.remove(data);
    notifyListeners();
  }

  void updatecontact({required Contact data,required int id}){
    allcontact[id]=data;
    notifyListeners();
  }

  void hidecontact({required Contact data}){
    hiddencontacts.add(data);
    notifyListeners();
}

}