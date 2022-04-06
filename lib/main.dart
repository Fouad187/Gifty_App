import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gifty/Providers/cart.dart';
import 'package:gifty/Screens/Admin/admin_all_gifts_screen.dart';
import 'package:gifty/Screens/Admin/admin_home_screen.dart';
import 'package:gifty/Screens/User/user_home_screen.dart';
import 'package:provider/provider.dart';

import 'Providers/admin_data.dart';
import 'Providers/modal_hud.dart';
import 'Providers/navigation.dart';
import 'Providers/user_data.dart';
import 'Screens/Auth/login_screen.dart';
import 'Screens/Auth/register_screen.dart';
import 'Screens/User/Taps/user_cart_tap.dart';
import 'Screens/User/payment_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModalHud>(create: (context) => ModalHud(),),
        ChangeNotifierProvider<AdminData>(create: (context) => AdminData(),),
        ChangeNotifierProvider<UserData>(create: (context) => UserData(),),
        ChangeNotifierProvider<BottomNavigation>(create: (context) => BottomNavigation(),),
        ChangeNotifierProvider<Cart>(create: (context) => Cart(),),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          /// Auth
          LoginScreen.id : (context)=> LoginScreen(),
          RegistrationScreen.id : (context)=> RegistrationScreen(),

          /// User
          UserHomeScreen.id:(context)=>UserHomeScreen(),
          CartTap.id:(context)=>CartTap(),
          PaymentScreen.id:(context)=>PaymentScreen(),

          /// Admin
          AdminHomeScreen.id:(context)=>AdminHomeScreen(),
          AdminAllGiftsScreen.id:(context)=>AdminAllGiftsScreen(),
        },
      ),
    );

  }
}
