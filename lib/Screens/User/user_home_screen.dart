import 'package:flutter/material.dart';
import 'package:gifty/Providers/navigation.dart';
import 'package:gifty/Screens/User/Taps/user_cart_tap.dart';
import 'package:gifty/Screens/User/Taps/user_custome_gift_tap.dart';
import 'package:gifty/Screens/User/Taps/user_home_tap.dart';
import 'package:gifty/Util/constant.dart';
import 'package:provider/provider.dart';

class UserHomeScreen extends StatelessWidget {
  static String id='UserHomeScreenID';

  final taps=[
    UserHomeTap(),
    CartTap(),
    UserCustomeGiftTap(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: fColor,
        currentIndex: Provider.of<BottomNavigation>(context).selectedIndex,
        onTap: (index){
          Provider.of<BottomNavigation>(context,listen:false).navigate(index: index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Custom Gift',
          ),
        ],
      ),
      body: taps[Provider.of<BottomNavigation>(context).selectedIndex],
    );
  }
}
