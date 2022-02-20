import 'package:flutter/cupertino.dart';
import 'package:gifty/Models/gift.dart';
import 'package:gifty/Models/user.dart';
import 'package:gifty/Services/admin_services.dart';

class AdminData extends ChangeNotifier
{
  UserModel? user;
  List<Gift> gifts=[];

  setUser(UserModel user)
  {
    this.user=user;
  }
  Future<void> getGifts() async
  {
    AdminServices.getGifts().then((value) {
      gifts=value;
      notifyListeners();
    });
  }
}