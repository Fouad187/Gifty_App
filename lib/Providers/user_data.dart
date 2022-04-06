
import 'package:flutter/material.dart';
import 'package:gifty/Models/gift.dart';
import 'package:gifty/Models/user.dart';
import 'package:gifty/Services/admin_services.dart';

class UserData extends ChangeNotifier
{
  UserModel? user;
  List<Gift> gifts=[];



  setUser(UserModel user)
  {
    this.user=user;
  }


  getGifts()
  {
    if(gifts.isEmpty)
      {
        AdminServices.getGifts().then((value) {
          gifts=value;
          notifyListeners();
        });
      }
  }
}