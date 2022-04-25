import 'package:flutter/material.dart';
import 'package:gifty/Models/user.dart';
import 'package:gifty/Providers/user_data.dart';
import 'package:gifty/Screens/Auth/login_screen.dart';
import 'package:gifty/Screens/User/CategoryTaps/accessories_tap.dart';
import 'package:gifty/Screens/User/CategoryTaps/choclate_tap.dart';
import 'package:gifty/Screens/User/CategoryTaps/home_decoration_tap.dart';
import 'package:gifty/Screens/User/CategoryTaps/others_tap.dart';
import 'package:gifty/Screens/User/CategoryTaps/perfume_tap.dart';
import 'package:gifty/Screens/User/update_ProfileScreen.dart';
import 'package:gifty/Screens/User/user_custom_gifts_screen.dart';
import 'package:gifty/Services/auth_services.dart';
import 'package:gifty/Util/constant.dart';
import 'package:gifty/Widgets/gift_widget.dart';
import 'package:gifty/Widgets/my_gift_widget.dart';
import 'package:provider/provider.dart';

import '../../../Providers/cart.dart';
import '../CategoryTaps/flowers_tap.dart';
import '../orders_screen.dart';
class UserHomeTap extends StatefulWidget {

  @override
  State<UserHomeTap> createState() => _UserHomeTapState();
}

class _UserHomeTapState extends State<UserHomeTap> {

  @override
  Widget build(BuildContext context) {
    UserModel? user=Provider.of<UserData>(context).user;

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gifty Store'),
          backgroundColor: fColor,
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: Scaffold(
            body: ListView(
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: fColor,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/adminlogo.png'),
                                fit: BoxFit.contain,
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Center(child: Text(user!.name, style:const TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ,color: Colors.white),)),
                      Center(child: Text(user.email,style: const TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ,color: Colors.white)),),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Update Profile', style: TextStyle(color: Colors.black),),
                  leading: Icon(Icons.person, color: fColor),
                  onTap: () async {
                   Navigator.pushNamed(context, UpdateProfileScreen.id);
                  },
                ),
                ListTile(
                  title: const Text('My Orders', style: TextStyle(color: Colors.black),),
                  leading: Icon(Icons.reorder, color: fColor),
                  onTap: () async {
                    await Provider.of<UserData>(context,listen: false).getOrders().then((value) {
                      Navigator.pushNamed(context, UserOrderScreen.id);
                    });
                  },
                ),
                ListTile(
                  title: const Text('My Custom Gifts', style: TextStyle(color: Colors.black),),
                  leading: Icon(Icons.reorder, color: fColor),
                  onTap: () async {
                    await Provider.of<UserData>(context,listen: false).getCustomGifts().then((value) {
                      Navigator.pushNamed(context, UserMyCustomGiftsScreen.id);
                    });
                  },
                ),

                ListTile(
                  title: const Text('Log out', style: TextStyle(color: Colors.black),),
                  leading: Icon(Icons.logout, color: fColor),
                  onTap: () async {
                    Auth auth=Auth();
                    auth.signOut();
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories' , style: TextStyle(color: Colors.black , fontSize: 20 , fontWeight: FontWeight.bold),),
              const TabBar(
                indicatorColor: Colors.red,
                labelColor: fColor,
                unselectedLabelColor: const Color(0xFFCDCDCD),
                physics: BouncingScrollPhysics(),
                isScrollable: true,
                tabs: [
                  Tab(child: Text('Flowers'),),
                  Tab(child: Text('Chocolate'),),
                  Tab(child: Text('Home Decoration'),),
                  Tab(child: Text('Accessories'),),
                  Tab(child: Text('Perfume'),),
                  Tab(child: Text('Others'),),
                ],
              ),
              SizedBox(height: 15,),
              Expanded(
                child: TabBarView(
                  children: [
                    FlowersTap(),
                    ChoclateTap(),
                    HomeDecorationTap(),
                    AccessoriesTap(),
                    PerfumeTap(),
                    OthersTap(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
