import 'package:flutter/material.dart';
import 'package:gifty/Providers/admin_data.dart';
import 'package:gifty/Util/constant.dart';
import 'package:gifty/Widgets/user_my_custom_gift_card.dart';
import 'package:provider/provider.dart';

class AdminAllCustomGiftsScreen extends StatelessWidget {
 static String id='AdminAllCustomGiftScreenID';
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
          return UserMyCustomGiftCard(gift: Provider.of<AdminData>(context).allCustomGifts[index]);
        },
        itemCount: Provider.of<AdminData>(context).allCustomGifts.length,
      ),
    );  }
}
