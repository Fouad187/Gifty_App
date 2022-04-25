import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/user_data.dart';
import '../../../Widgets/gift_widget.dart';

class OthersTap extends StatefulWidget {

  @override
  _OthersTapState createState() => _OthersTapState();
}

class _OthersTapState extends State<OthersTap> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getOthers();
    });
  }
  getOthers()
  {
    Provider.of<UserData>(context,listen: false).getGiftByCategory(category: 'Others');
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10 , right: 10),
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
    );
  }
}
