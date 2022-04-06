import 'package:flutter/material.dart';
import 'package:gifty/Providers/user_data.dart';
import 'package:gifty/Util/constant.dart';
import 'package:gifty/Widgets/gift_widget.dart';
import 'package:gifty/Widgets/my_gift_widget.dart';
import 'package:provider/provider.dart';
class UserHomeTap extends StatefulWidget {

  @override
  State<UserHomeTap> createState() => _UserHomeTapState();
}

class _UserHomeTapState extends State<UserHomeTap> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getGifts();
    });
  }
  getGifts()
  {
    Provider.of<UserData>(context,listen: false).getGifts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gifty Store'),
        backgroundColor: fColor,
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${Provider.of<UserData>(context).gifts.length} Gift was Found'),
            Divider(),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 5 ,
                  childAspectRatio: 0.9,
                ),
                itemCount: Provider.of<UserData>(context).gifts.length,
                itemBuilder: (context, index) {
                  return GiftWidget(gift: Provider.of<UserData>(context).gifts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
