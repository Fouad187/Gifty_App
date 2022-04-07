import 'package:flutter/cupertino.dart';
import 'package:gifty/Models/custom_gift.dart';
import 'package:gifty/Models/gift.dart';
import 'package:gifty/Models/order.dart';
import 'package:gifty/Models/user.dart';
import 'package:gifty/Services/admin_services.dart';

class AdminData extends ChangeNotifier
{
  UserModel? user;
  List<Gift> gifts=[];
  List<Order> orders=[];
  List<Order> allOrders=[];
  List<CustomGift> customGifts=[];
  List<CustomGift> allCustomGifts=[];
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
  getAdminOrders()
  {
    AdminServices.getOrders().then((value) {
      orders=value;
      notifyListeners();
    });
  }
  removeFromOrders({required int index})
  {
    orders.removeAt(index);
    notifyListeners();
  }
  Future<void> getAllOrders() async
  {
    AdminServices.getAllOrders().then((value) {
      allOrders=value;
      notifyListeners();
    });
  }
  removeFromCustomGifts({required int index})
  {
    customGifts.removeAt(index);
    notifyListeners();
  }
  Future<void> getCustomGifts() async
  {
    AdminServices.getCustomGifts().then((value) {
      customGifts=value;
      notifyListeners();
    });
  }

  Future<void> getAllCustomGifts() async
  {
    AdminServices.getAllCustomGifts().then((value) {
      allCustomGifts=value;
      notifyListeners();
    });
  }

}