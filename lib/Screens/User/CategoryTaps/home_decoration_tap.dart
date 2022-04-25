import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/user_data.dart';
import '../../../Widgets/gift_widget.dart';

class HomeDecorationTap extends StatefulWidget {

  @override
  _HomeDecorationTapState createState() => _HomeDecorationTapState();
}

class _HomeDecorationTapState extends State<HomeDecorationTap> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getHomeDecoration();
    });
  }
  getHomeDecoration()
  {
    Provider.of<UserData>(context,listen: false).getGiftByCategory(category: 'Home Decoration');
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
