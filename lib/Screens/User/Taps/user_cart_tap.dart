import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gifty/Providers/cart.dart';
import 'package:gifty/Util/constant.dart';
import 'package:gifty/Widgets/cart_card.dart';
import 'package:provider/provider.dart';

import '../payment_screen.dart';

class CartTap extends StatelessWidget {

  static String id='CartTapID';

  @override
  Widget build(BuildContext context) {
    Cart cart=Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: fColor,
        centerTitle: true,
      ),
      body: cart.gifts.length >= 1 ? Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.gifts.length,
              itemBuilder: (context, index) {
                return CartCard(gift: cart.gifts[index],);
              },
            ),
          ),
          Container(
              width: double.infinity,
              height: 50,
              child: FlatButton(
                onPressed: ()  {

                  Navigator.pushNamed(context, PaymentScreen.id);

                }, child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Confirm' , style: TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.bold),),
                  Text(' Total : ${cart.calculatePrice().toString()} LE' , style: const TextStyle(color: Colors.white),),
                ],
              ) , color: Colors.green,)),
        ],
      ) : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: SvgPicture.asset('assets/images/empty.svg', width: 200, height: 200,)),
          const SizedBox(height: 10,),
          const Text('Empty Cart' , style: TextStyle(fontSize: 18),),        ],
      ),
    );  }
}
