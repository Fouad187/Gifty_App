import 'package:flutter/material.dart';
import 'package:gifty/Models/gift.dart';
import 'package:gifty/Screens/User/gift_description.dart';
class GiftWidget extends StatelessWidget {
  Gift gift;
  GiftWidget({required this.gift});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => GiftDescriptionScreen(gift: gift,),));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            width: 155,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Hero(
                    tag: gift.image,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(gift.image),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Padding(
                  padding:const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(gift.name , style:const TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 5,),
                      Text('${gift.type} Type' , style: const TextStyle(color: Colors.grey),),
                      Text('${gift.price} LE' , style: const TextStyle(fontWeight: FontWeight.bold , color: Colors.grey),),
                      const SizedBox(height: 5,),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
