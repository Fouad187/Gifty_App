import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gifty/Models/custom_gift.dart';
import 'package:gifty/Models/gift.dart';
import 'package:gifty/Models/order.dart';
import 'package:gifty/Models/user.dart';
import 'package:gifty/Providers/admin_data.dart';
import 'package:gifty/Providers/user_data.dart';
import 'package:gifty/Util/constant.dart';
import 'package:provider/provider.dart';

class UserService
{
  Future<void> addCustomGift({required String name, required String price,required String description ,required String type, required File image , context}) async
  {
    UserModel? user=Provider.of<UserData>(context , listen: false).user;

    final ref=FirebaseStorage.instance.ref().child('Custom_Gifts_Photo').child('${getRandomId()}.jpg');
    await ref.putFile(image);
    final url=await ref.getDownloadURL();
    CustomGift gift=CustomGift(
      name: name,
      description: description,
      image: url,
      price: price,
      type: type,
      userId: user!.id,
      userEmail: user.email,
      userName: user.name,
    );
    await FirebaseFirestore.instance.collection('Custom').doc().set(gift.toJson());
  }

  static Future<void> makeOrder({required Order order}) async
  {
    await FirebaseFirestore.instance.collection('Orders').doc().set(order.toJson());
  }
  static Future<List<Order>> getMyOrders({required String userId}) async
  {
    List<Order> orders=[];
    await FirebaseFirestore.instance.collection('Orders').where('userId' , isEqualTo: userId).get().then((value){
      for(int i=0 ; i<value.docs.length ; i++)
      {
        orders.add(Order.fromJson(value.docs[i].data()));
      }
    });
    return orders;
  }
}