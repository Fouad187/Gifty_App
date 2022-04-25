import 'package:flutter/material.dart';
import 'package:gifty/Util/constant.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    required this.label,
    required this.picon,
    required this.controller,
    required this.validate,
    this.keyType = TextInputType.text,
    this.security = false,
    this.disable=false,
  });
  Icon picon;
  String label;
  TextInputType keyType;
  bool security = false;
  bool disable;
  TextEditingController controller;
  final String? Function(String?)? validate;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: security,
      keyboardType: keyType,
      readOnly: disable,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelStyle: TextStyle(color: fColor),
        prefixIcon: picon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: const BorderSide(
            color: fColor,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      validator: validate,
    );
  }
}