
import 'package:flutter/material.dart';
import 'package:gifty/Providers/admin_data.dart';
import 'package:gifty/Util/constant.dart';
import 'package:gifty/Widgets/user_order_card.dart';
import 'package:provider/provider.dart';


class AdminAllOrdersScreen extends StatelessWidget {
  static String id='AdminAllOrdersScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Orders'),
        centerTitle: true,
        backgroundColor: fColor,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return UserOrderCard(order: Provider.of<AdminData>(context).allOrders[index]);
        },
        itemCount: Provider.of<AdminData>(context).allOrders.length,
      ),
    );
  }
}
