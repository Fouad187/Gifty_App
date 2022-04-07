
import 'package:flutter/material.dart';
import 'package:gifty/Models/custom_gift.dart';
import 'package:gifty/Models/gift.dart';
import 'package:gifty/Models/order.dart';
import 'package:gifty/Models/user.dart';
import 'package:gifty/Services/admin_services.dart';
import 'package:gifty/Services/user_service.dart';

class UserData extends ChangeNotifier
{
  UserModel? user;
  List<Gift> gifts=[];
  List<Order> orders=[];
  List<CustomGift> customGifts=[];
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
  Future<void> getOrders() async
  {
    UserService.getMyOrders(userId: user!.id).then((value) {
      orders=value;
      notifyListeners();
    });
  }
  Future<void> getCustomGifts() async
  {
    UserService.getMyCustomGifts(userId: user!.id).then((value) {
      customGifts=value;
      notifyListeners();
    });
  }


}