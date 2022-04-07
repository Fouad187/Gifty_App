import 'package:flutter/material.dart';
import 'package:gifty/Models/user.dart';
import 'package:gifty/Providers/user_data.dart';
import 'package:gifty/Screens/Auth/login_screen.dart';
import 'package:gifty/Screens/User/user_custom_gifts_screen.dart';
import 'package:gifty/Services/auth_services.dart';
import 'package:gifty/Util/constant.dart';
import 'package:gifty/Widgets/gift_widget.dart';
import 'package:gifty/Widgets/my_gift_widget.dart';
import 'package:provider/provider.dart';

import '../orders_screen.dart';
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
    UserModel? user=Provider.of<UserData>(context).user;

    return Scaffold(
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
                decoration: BoxDecoration(
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
                    Center(child: Text(user!.name, style:const TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ,color: Colors.white),)),
                    Center(child: Text(user.email,style: const TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ,color: Colors.white)),),
                  ],
                ),
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
