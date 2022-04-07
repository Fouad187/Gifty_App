import 'package:flutter/material.dart';
import 'package:gifty/Providers/admin_data.dart';
import 'package:gifty/Screens/Admin/admin_all_custom_gifts.dart';
import 'package:gifty/Screens/Admin/admin_all_gifts_screen.dart';
import 'package:gifty/Screens/Auth/login_screen.dart';
import 'package:gifty/Services/auth_services.dart';
import 'package:gifty/Util/constant.dart';
import 'package:provider/provider.dart';

import 'Taps/add_gift_tap.dart';
import 'Taps/admin_custom_gift_tap.dart';
import 'Taps/admin_home_tap.dart';
import 'admin_all_orders.dart';

class AdminHomeScreen extends StatefulWidget {
  static String id='AdminHomeScreenID';
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  int selectedIndex=0;

  final taps=[
    AdminHomeTap(),
    AddGiftTap(),
    AdminCustomGiftTap(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fColor,
        title: const Text('Admin Panel'),
      ),
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
                              image: AssetImage('assets/images/adminlogo2.png'),
                              fit: BoxFit.contain,
                            )
                        ),
                      ),
                    ),
                    const Center(child: Text('Admin', style:const TextStyle( fontSize: 25 , fontWeight: FontWeight.bold ,color: Colors.white),)),
                  ],
                ),
              ),
              ListTile(
                title: const Text('My Gifts', style: TextStyle(color: Colors.black),),
                leading:const Icon(Icons.medical_services, color: fColor),
                onTap: (){
                  Provider.of<AdminData>(context,listen: false).getGifts().then((value) {
                    Navigator.pushNamed(context,AdminAllGiftsScreen.id);
                  });
                },

              ),
              ListTile(
                title: const Text('All Orders', style: TextStyle(color: Colors.black),),
                leading: const Icon(Icons.reorder, color: fColor),
                onTap: (){
                  Provider.of<AdminData>(context,listen: false).getAllOrders().then((value) {
                    Navigator.pushNamed(context,AdminAllOrdersScreen.id);
                  });
                },
              ),
              ListTile(
                title: const Text('All Custom Gift', style: TextStyle(color: Colors.black),),
                leading: const Icon(Icons.reorder, color: fColor),
                onTap: (){
                  Provider.of<AdminData>(context,listen: false).getAllCustomGifts().then((value) {
                    Navigator.pushNamed(context,AdminAllCustomGiftsScreen.id);
                  });
                },
              ),
              ListTile(
                title: const Text('Log out', style: TextStyle(color: Colors.black),),
                leading: const Icon(Icons.logout, color: fColor),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: fColor,
        currentIndex: selectedIndex, //0
        onTap: (index){
          setState(() {
            selectedIndex=index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Gift',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reorder),
            label: 'Custom Gifts',
          ),
        ],
      ),
      body: taps[selectedIndex],
    );

  }
}
