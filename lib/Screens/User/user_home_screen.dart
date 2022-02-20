import 'package:flutter/material.dart';
import 'package:gifty/Util/constant.dart';

class UserHomeScreen extends StatelessWidget {
  static String id='UserHomeScreenID';
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: fColor,
      ),
      body: Center(child: Text('HomeScreen'),),
    );
  }
}
