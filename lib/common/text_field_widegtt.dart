import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
 final TextInputType? textInputType;
  TextFieldWidget({this.controller, this.hint,this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        decoration: inputDecoration(hintName: hint),
      ),
    );
  }

  InputDecoration inputDecoration({String? hintName}) {
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.black)),
        border: OutlineInputBorder(),
        hintText: hintName,
        hintStyle: TextStyle(color: Colors.black54));
  }
}
