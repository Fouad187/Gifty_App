import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gifty/Models/custom_gift.dart';
import 'package:gifty/Models/gift.dart';
import 'package:gifty/Models/order.dart';
import 'package:gifty/Models/user.dart';
import 'package:gifty/Providers/admin_data.dart';
import 'package:gifty/Util/constant.dart';
import 'package:provider/provider.dart';


class AdminServices

{


  Future<void> addNewGift({required String name, required String price,required String description ,required String type, required File image , context}) async
  {
    UserModel? user=Provider.of<AdminData>(context , listen: false).user;

    final ref=FirebaseStorage.instance.ref().child('Gifts_Photo').child('${getRandomId()}.jpg');
    await ref.putFile(image);
    final url=await ref.getDownloadURL();
    Gift gift=Gift(
      id: user!.id,
      name: name,
      description: description,
      image: url,
      price: price,
      type: type,
    );
    await FirebaseFirestore.instance.collection('Gifts').doc().set(gift.toJson());

  }

  static Future<List<Gift>> getGifts() async
  {
    List<Gift> gift=[];
    await FirebaseFirestore.instance.collection('Gifts').get().then((value) {
      for(int i = 0; i < value.docs.length; i++)
      {
        gift.add(Gift.fromJson(value.docs[i].data()));
        gift[i].docId=value.docs[i].id;
      }
    });
    return gift;
  }

  static Future<List<Order>> getOrders() async
  {
    List<Order> orders=[];
    await FirebaseFirestore.instance.collection('Orders').where('status' , isEqualTo: 'In Review').get().then((value) {
      for(int i=0 ; i<value.docs.length ; i++)
      {
        orders.add(Order.fromJson(value.docs[i].data()));
        orders[i].docId=value.docs[i].id;
      }
    });
    return orders;
  }

  static Future<List<Order>> getAllOrders() async
  {
    List<Order> orders=[];
    await FirebaseFirestore.instance.collection('Orders').get().then((value) {
      for(int i=0 ; i<value.docs.length ; i++)
      {
        orders.add(Order.fromJson(value.docs[i].data()));
        orders[i].docId=value.docs[i].id;
      }
    });
    return orders;
  }

  static Future<List<CustomGift>> getCustomGifts() async
  {
    List<CustomGift> gifts=[];
    await FirebaseFirestore.instance.collection('Custom').where('status' , isEqualTo: 'In Review').get().then((value) {
      for(int i=0 ; i<value.docs.length ; i++)
      {
        gifts.add(CustomGift.fromJson(value.docs[i].data()));
        gifts[i].docId=value.docs[i].id;
      }
    });
    return gifts;
  }
  static Future<List<CustomGift>> getAllCustomGifts() async
  {
    List<CustomGift> gifts=[];
    await FirebaseFirestore.instance.collection('Custom').get().then((value) {
      for(int i=0 ; i<value.docs.length ; i++)
      {
        gifts.add(CustomGift.fromJson(value.docs[i].data()));
        gifts[i].docId=value.docs[i].id;
      }
    });
    return gifts;
  }
}