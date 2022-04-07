import 'package:flutter/material.dart';
import 'package:gifty/Providers/admin_data.dart';
import 'package:gifty/Widgets/admin_custom_gift_order_card.dart';
import 'package:provider/provider.dart';

class AdminCustomGiftTap extends StatefulWidget {
  const AdminCustomGiftTap({Key? key}) : super(key: key);

  @override
  State<AdminCustomGiftTap> createState() => _AdminCustomGiftTapState();
}

class _AdminCustomGiftTapState extends State<AdminCustomGiftTap> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getCustomGifts();
    });
  }

  getCustomGifts()
  {
    Provider.of<AdminData>(context,listen: false).getCustomGifts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Center(child: Text('Custom Gifts Board' , style: TextStyle(fontSize: 18),)),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return AdminCustomGiftOrderCard(gift: Provider.of<AdminData>(context).customGifts[index] , index: index,);
                },
                itemCount:Provider.of<AdminData>(context).customGifts.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
