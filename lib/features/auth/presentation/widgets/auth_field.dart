import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  AuthField({required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(controller: controller, decoration: InputDecoration(hintText: hintText),validator: (value){
      if(value!.isEmpty){
        return "$hintText is missing";
      }else{
        return null;
      }
    },);
  }
}
