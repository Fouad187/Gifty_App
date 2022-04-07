
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gifty/Models/gift.dart';
import 'package:gifty/Providers/cart.dart';
import 'package:gifty/Screens/User/Taps/user_cart_tap.dart';
import 'package:gifty/Util/constant.dart';
import 'package:provider/provider.dart';

class GiftDescriptionScreen extends StatefulWidget {
  Gift gift;
  GiftDescriptionScreen({required this.gift});

  @override
  State<GiftDescriptionScreen> createState() => _GiftDescriptionState();
}

class _GiftDescriptionState extends State<GiftDescriptionScreen> {
  int count=1;
  add()
  {
    setState(() {
      count++;
    });
  }
  min()
  {
    if(count >= 2)
    {
      setState(() {
        count--;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fColor,
        title: Text(widget.gift.name),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10 , top: 10),
            child: InkWell(
              onTap: (){
                Navigator.pushNamed(context, CartTap.id);
              },
              child: Stack(
                children: [
                  const Icon(Icons.shopping_cart ,size: 30,),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.5),
                        color: Colors.green,
                      ),
                      child: Center(child: Text('${Provider.of<Cart>(context).gifts.length}' , style: const TextStyle(color: Colors.white),)),
                    ),
                  ),
                ],
              ),
            ),

          ),
        ],
      ),
      body: ListView(
        children: [
          Hero(
            tag: widget.gift.image,
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.gift.image), fit: BoxFit.fill)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.gift.name,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.gift.description,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Type :${widget.gift.type}',
                  style: const TextStyle(fontSize: 18),
                ),

                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Verfied By Admin',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('  ${widget.gift.price}',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w800)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  min();
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.black),
                                  child: const Center(
                                      child: Text(
                                    '-',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  )),
                                ),
                              ),
                              Text('$count',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  add();
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: fColor,
                                  ),
                                  child: const Center(
                                      child: Text(
                                    '+',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: (){
                        final instance=Provider.of<Cart>(context , listen: false);
                        widget.gift.quantity=count;
                        widget.gift.totalPrice=count*(double.parse(widget.gift.price));
                        instance.addToCart(gift: widget.gift);
                        Fluttertoast.showToast(msg: 'item added successfully');
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Add To Cart' , style: TextStyle(color: Colors.white),),
                      color: fColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
