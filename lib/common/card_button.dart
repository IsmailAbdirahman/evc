import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String? value;

  CardButton({this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Container(
        height: 80,
        width: double.infinity,
        child: Card(
          elevation: 20,
          shadowColor: Colors.green,
          child: Center(
              child: Text(
            value!,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
          )),
        ),
      ),
    );
  }
}
