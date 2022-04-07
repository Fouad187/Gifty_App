import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gifty/Models/custom_gift.dart';
import 'package:gifty/Providers/admin_data.dart';
import 'package:provider/provider.dart';

import 'gift_in_order_widget.dart';
class AdminCustomGiftOrderCard extends StatefulWidget {

  CustomGift gift;
  int index;
  AdminCustomGiftOrderCard({required this.gift , required this.index});
  @override
  _AdminCustomGiftOrderCardState createState() => _AdminCustomGiftOrderCardState();
}

class _AdminCustomGiftOrderCardState extends State<AdminCustomGiftOrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Center(child: Text('Custom Gifts' , style: TextStyle(fontWeight: FontWeight.w700),),),
            Divider(),
            Container(
              width: double.infinity,
              height: 250,
              child: GiftInOrderWidget(gift: widget.gift.gift),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Name : ${widget.gift.userName}' , style: TextStyle(fontSize: 18),),
                Text('Address : ${widget.gift.address}', style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total : ${widget.gift.gift.price} LE' , style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            Container(
                width: double.infinity,
                child: FlatButton(onPressed: () async {
                  await FirebaseFirestore.instance.collection('Custom').doc(widget.gift.docId).update(
                      {
                        'status' : 'Accepted'
                      }
                  ).then((value) {
                    Provider.of<AdminData>(context,listen: false).removeFromCustomGifts(index: widget.index);
                  });
                }, child: const Text('Accept' , style:  TextStyle(color: Colors.white),) , color: Colors.green,)),
            Container(
                width: double.infinity,
                child: FlatButton(onPressed: () async {
                  await FirebaseFirestore.instance.collection('Custom').doc(widget.gift.docId).update(
                      {
                        'status' : 'Rejected'
                      }
                  ).then((value) {
                    Provider.of<AdminData>(context,listen: false).removeFromCustomGifts(index: widget.index);
                  });
                }, child: const Text('Refused' , style:  TextStyle(color: Colors.white),) , color: Colors.redAccent,)),
          ],
        ),
      ),
    );

  }
}
