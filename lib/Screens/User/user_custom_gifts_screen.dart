import 'package:flutter/material.dart';
import 'package:gifty/Providers/user_data.dart';
import 'package:gifty/Util/constant.dart';
import 'package:gifty/Widgets/user_my_custom_gift_card.dart';
import 'package:provider/provider.dart';

class UserMyCustomGiftsScreen extends StatelessWidget {
  static String id='UserMyCustomGiftScreenID';

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
          return UserMyCustomGiftCard(gift :Provider.of<UserData>(context).customGifts[index]);
        },
        itemCount: Provider.of<UserData>(context).customGifts.length,
      ),
    );
  }
}
