

import 'dart:math';

import 'package:flutter/material.dart';

const fColor=Color(0xFFC30016);
String getRandomId()
{
  var rng = new Random();
  String randomName="";
  for (var i = 0; i < 20; i++) {
    randomName += rng.nextInt(100).toString();
  }
  return randomName;
}
List<String> cities=[
  'Riyadh',
  'Jeddah',
  'Dammam',
  'Medina',
  'Cairo',
  'Alex',
  '6 October',
  'Al Khobar',
  'Najran',
  'Abha',
  'Dhahran',
  'Mansoura',
  'Giza',
  'Tabuk',
  'Al-Kharij',
  'Taif',
  'Other',
];

List<DropdownMenuItem> getitem(List<String> list)
{
  List<DropdownMenuItem> dropdownmenuitem=[];
  for(int i=0 ; i<list.length; i++)
  {
    String type=list[i];
    var newitem=DropdownMenuItem(
      child: Text(type) ,
      value: type,
    );
    dropdownmenuitem.add(newitem);
  }
  return dropdownmenuitem;
}
