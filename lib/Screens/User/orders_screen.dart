
import 'package:flutter/material.dart';
import 'package:gifty/Models/order.dart';
import 'package:gifty/Providers/user_data.dart';
import 'package:gifty/Util/constant.dart';
import 'package:gifty/Widgets/user_order_card.dart';
import 'package:provider/provider.dart';

class UserOrderScreen extends StatelessWidget {
  static String id='UserOrderScreenId';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Orders'),
        centerTitle: true,
        backgroundColor: fColor,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return UserOrderCard(order:Provider.of<UserData>(context).orders[index]);
        },
        itemCount: Provider.of<UserData>(context).orders.length,
      ),
    );
  }
}

