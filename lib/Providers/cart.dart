import 'package:flutter/cupertino.dart';
import 'package:gifty/Models/custom_gift.dart';
import 'package:gifty/Models/gift.dart';

class Cart extends ChangeNotifier {

  List<Gift> gifts=[];
  Gift? myGift;

  setMyCustomGift(Gift gift)
  {
    myGift=gift;
    notifyListeners();
  }
  addToCart({required Gift gift})
  {
    gifts.add(gift);
    notifyListeners();
  }

  deleteFromCart({required Gift gift})
  {
    gifts.remove(gift);
    notifyListeners();
  }

  double calculatePrice()
  {
    double sum=0;
    for(var product in gifts)
      {
        sum+=product.totalPrice!;
      }
    return sum;
  }
  void clear()
  {
    gifts.clear();
    notifyListeners();
  }
}