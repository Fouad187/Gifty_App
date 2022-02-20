import 'package:flutter/material.dart';
import 'package:gifty/Providers/admin_data.dart';
import 'package:gifty/Util/constant.dart';
import 'package:gifty/Widgets/my_gift_widget.dart';
import 'package:provider/provider.dart';

class AdminAllGiftsScreen extends StatelessWidget {

  static String id='AdminAllGiftsScreenID';
  const AdminAllGiftsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fColor,
        title: const Text('Medicines'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MyGiftWidget(gift: Provider.of<AdminData>(context).gifts[index] , index: index,name: 'Medicine',);
        },
        itemCount: Provider.of<AdminData>(context).gifts.length,
      ),
    );
  }
}
