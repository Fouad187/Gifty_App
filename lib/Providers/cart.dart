import 'package:flutter/cupertino.dart';
import 'package:gifty/Models/custom_gift.dart';
import 'package:gifty/Models/gift.dart';

class Cart extends ChangeNotifier {

  List<Gift> gifts=[];
  Gift? myGift;
  int numberOfProducts=0;

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
  updateNumberOfProducts(int number)
  {
    numberOfProducts=numberOfProducts+number;
    notifyListeners();
  }
  removeCart()
  {
    numberOfProducts=0;
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