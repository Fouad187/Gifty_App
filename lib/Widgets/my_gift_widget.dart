import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gifty/Models/gift.dart';
import 'package:gifty/Providers/admin_data.dart';
import 'package:gifty/Util/constant.dart';
import 'package:provider/provider.dart';

class MyGiftWidget extends StatelessWidget {
  Gift gift;
  int index;
  MyGiftWidget({required this.gift , required this.index});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 2,
        child: Container(
          padding:  const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(gift.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(gift.name,  style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.w500),),
                    Text(gift.type, style: const TextStyle(color: Colors.grey),),
                    const SizedBox(height: 10,),

                    Text('${gift.price} LE ', style: const TextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis,),
                    const SizedBox(height: 5,),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              GestureDetector(
                  onTap: () async{
                    await FirebaseFirestore.instance.collection('Gifts').doc(gift.docId).delete().then((value) {
                      Provider.of<AdminData>(context,listen: false).removeFromGifts(index: index);

                    });

                  },
                  child: Icon(Icons.delete , color: fColor,)),

            ],
          ),
        ),
      ),
    );

  }
}
