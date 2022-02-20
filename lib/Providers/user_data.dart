
import 'package:flutter/material.dart';
import 'package:gifty/Models/gift.dart';
import 'package:gifty/Models/user.dart';

class UserData extends ChangeNotifier
{
  UserModel? user;
  List<Gift> gifts=[];


  setUser(UserModel user)
  {
    this.user=user;
  }
}