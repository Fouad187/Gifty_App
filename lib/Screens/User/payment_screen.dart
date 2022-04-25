import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gifty/Models/custom_gift.dart';
import 'package:gifty/Models/gift.dart';
import 'package:gifty/Models/order.dart';
import 'package:gifty/Models/payment.dart';
import 'package:gifty/Models/user.dart';
import 'package:gifty/Providers/cart.dart';
import 'package:gifty/Providers/modal_hud.dart';
import 'package:gifty/Providers/navigation.dart';
import 'package:gifty/Providers/user_data.dart';
import 'package:gifty/Screens/User/user_home_screen.dart';
import 'package:gifty/Services/user_service.dart';
import 'package:gifty/Util/constant.dart';
import 'package:gifty/Widgets/payment_card.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';


class PaymentScreen extends StatefulWidget {
  static String id='PaymentScreenId';

  bool fromCustom;
  File? customImage;
  PaymentScreen({this.fromCustom=false , this.customImage});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController adressController=TextEditingController();
  String selectedCity='Other';
  UserService userService = UserService();


  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModalHud>(context).isChange,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width,
                height: size.height*0.1,
                color: Colors.blue,
                child: const Center(child: Text('Payment Methods' , style: TextStyle(color: Colors.white , fontSize: 20),)),
              ),
              Container(
                width: size.width,
                height: size.height*0.15,
                color: Colors.grey.shade200,
                child: ListView.builder(
                  itemCount: paymentsWay.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return PaymentCard(
                      image: paymentsWay[index].image,
                      name: paymentsWay[index].name,
                    );
                  },
                ),
              ),
              Expanded(child: Container(width: size.width,
                padding: const EdgeInsets.all(35),
                child: SingleChildScrollView(
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CARD NUMBER', style: TextStyle(color: Colors.grey.shade400),),
                        SizedBox(height: 5,),
                        TextFormField(
                          inputFormatters: [
                            CreditCardNumberInputFormatter()
                          ],
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Please Fill Card';
                            }
                          },
                          style: const TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: const TextStyle(fontSize: 20),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade500,
                                )
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade500,
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade500,
                                )
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('EXPRIRATION DATE', style: TextStyle(color: Colors.grey.shade400),),
                                  const SizedBox(height: 5,),
                                  TextFormField(
                                    inputFormatters: [
                                      CreditCardExpirationDateFormatter(),
                                    ],
                                    validator: (value)
                                    {
                                      if(value!.isEmpty)
                                      {
                                        return 'Please Fill Expriration date';
                                      }
                                    },
                                    style: const TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                      hintText: '00/00',
                                      hintStyle: const TextStyle(fontSize: 18),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade500,
                                          )
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade500,
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade500,
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CVV', style: TextStyle(color: Colors.grey.shade400),),
                                  const SizedBox(height: 5,),
                                  TextFormField(
                                    inputFormatters: [
                                      CreditCardCvcInputFormatter(),
                                    ],
                                    validator: (value)
                                    {
                                      if(value!.isEmpty)
                                      {
                                        return 'Please Fill CVV';
                                      }
                                    },
                                    obscureText: true,
                                    style: const TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                      hintText: 'XXXX',
                                      hintStyle: const TextStyle(fontSize: 18),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade500,
                                          )
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade500,
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade500,
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30,),
                        Text('Adress', style: TextStyle(color: Colors.grey.shade400),),
                        const SizedBox(height: 5,),
                        TextFormField(
                          style: const TextStyle(fontSize: 20),
                          controller: adressController,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Please Fill Address';
                            }
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade500,
                                )
                            ),

                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade500,
                                )
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade500,
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            const Text('City : ' , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold),),
                            const SizedBox(width: 10,),
                            DropdownButton(items: getitem(cities), value:selectedCity, onChanged: (dynamic value){
                              setState(() {
                                selectedCity=value;
                              });
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
              InkWell(
                onTap: () async {
                  final instance=Provider.of<ModalHud>(context , listen: false);
                  instance.changeIsLoading(true);
                  if(_globalKey.currentState!.validate())
                  {
                    _globalKey.currentState!.save();
                    if(selectedCity != 'Other')
                      {
                        try{
                          if(widget.fromCustom)
                            {
                              Gift? customGift=Provider.of<Cart>(context,listen: false).myGift;
                              if(customGift != null )
                                {
                                  userService.addCustomGift(
                                      gifty: customGift,
                                      image: widget.customImage!,
                                      address: adressController.text,
                                      city: selectedCity,
                                      context: context,
                                  ).then((value) {
                                    instance.changeIsLoading(false);
                                    Provider.of<BottomNavigation>(context,listen: false).navigate(index: 0);
                                    Navigator.pushNamedAndRemoveUntil(context, UserHomeScreen.id, (route) => false);
                                    Fluttertoast.showToast(msg: 'Your Custom Gift Added Successfully We will Call You soon ' , toastLength: Toast.LENGTH_LONG);

                                  });
                                }
                              else
                                {
                                  instance.changeIsLoading(false);
                                  Fluttertoast.showToast(msg: 'Something was wrong' , toastLength: Toast.LENGTH_LONG);
                                }
                            }
                          else
                            {

                              UserModel? userInstance=Provider.of<UserData>(context,listen: false).user;
                              final cart=Provider.of<Cart>(context,listen: false);

                              Order order=Order(
                                  userName: userInstance!.name,
                                  totalPrice: cart.calculatePrice(),
                                  address: adressController.text,
                                  order: cart.gifts,
                                  userId: userInstance.id,
                                  status: 'In Review',
                                  city: selectedCity,
                                  date: DateTime.now()
                              );
                              await UserService.makeOrder(order: order).then((value) {
                                cart.clear();
                                cart.removeCart();
                                instance.changeIsLoading(false);
                                Provider.of<BottomNavigation>(context,listen: false).navigate(index: 0);
                                Navigator.pushNamedAndRemoveUntil(context, UserHomeScreen.id, (route) => false);
                                Fluttertoast.showToast(msg: 'Your Orders Successfully We will Call You soon ' , toastLength: Toast.LENGTH_LONG);
                              });
                            }

                      } catch(e){
                        instance.changeIsLoading(false);
                        Fluttertoast.showToast(msg: 'Something was wrong' , toastLength: Toast.LENGTH_LONG);
                      }


                      }
                    else
                      {
                        instance.changeIsLoading(false);
                        Fluttertoast.showToast(msg: 'Please Select Your City' , toastLength: Toast.LENGTH_LONG);

                      }

                  }
                },
                child: Container(
                  width: size.width,
                  height: size.height*0.1,
                  color: Colors.green,
                  child: Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('CONFIRM PAYMENT' , style: TextStyle(color: Colors.white , fontSize: 22),),
                      widget.fromCustom ? Text('Total Start Pay 200 LE' , style: const TextStyle(color: Colors.white),)
                          :Text('Total ${Provider.of<Cart>(context).calculatePrice()} LE' , style: const TextStyle(color: Colors.white),),
                    ],
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
