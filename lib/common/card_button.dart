import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String? code;
  final String? buttonText;

  CardButton({this.buttonText, this.code});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Container(
        height: 80,
        width: double.infinity,
        child: Card(
          color: Colors.greenAccent[400],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17), // if you need this
            side: BorderSide(
              color: Colors.white,
              width: 2.4,
            ),
          ),
          elevation: 2,
          shadowColor: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  buttonText!,
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white38,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        code!,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
