
import 'package:flutter/material.dart';
import 'package:gifty/Models/gift.dart';
import 'package:gifty/Providers/cart.dart';
import 'package:gifty/Util/constant.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  Gift gift;
  CartCard({required this.gift});
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              width: size.width*0.4,
              height: size.height*0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(gift.image),
                    fit: BoxFit.fill,
                  )
              ),
            ),
           const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(gift.name , style: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Text('${gift.price} LE' , style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                Text('Q : ${gift.quantity}' , style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),

                Container(
                    width: size.width*0.45,
                    child: FlatButton(onPressed: (){
                      final instance=Provider.of<Cart>(context , listen: false);
                      instance.deleteFromCart(gift: gift);
                    }, child: const Text('Remove From Cart' , style:  TextStyle(color: Colors.white),) , color: fColor,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
