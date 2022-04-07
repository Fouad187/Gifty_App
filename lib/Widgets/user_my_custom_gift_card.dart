import 'package:flutter/material.dart';
import 'package:gifty/Models/custom_gift.dart';
import 'package:gifty/Models/gift.dart';

import 'gift_in_order_widget.dart';

class UserMyCustomGiftCard extends StatelessWidget {

  CustomGift gift;
  UserMyCustomGiftCard({required this.gift});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Center(child: Text('Custom Gift Details' , style: TextStyle(fontWeight: FontWeight.w700),),),
            Divider(),
            Container(
                height: 250,
                width: double.infinity,
                child: GiftInOrderWidget(gift: gift.gift)),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Name : ${gift.userName}' , style: TextStyle(fontSize: 18),),
                Text('Address : ${gift.address}', style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total : ${gift.gift.price} LE' , style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                color: gift.status=='In Review' ? Colors.yellow : gift.status=='Accepted' ? Colors.green : Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child : gift.status=='In Review' ? Text('In Review') : gift.status=='Accepted' ?
              Text('Accepted',style: TextStyle(color: Colors.white),) : Text('Rejected',style: TextStyle(color: Colors.white)),),
            ),

          ],
        ),
      ),
    );

  }
}
