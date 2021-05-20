import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'common/text_field_widegtt.dart';

class NumberAndAmountScreen extends StatefulWidget {
  final String? code;

  NumberAndAmountScreen({this.code});

  @override
  _NumberAndAmountScreenState createState() => _NumberAndAmountScreenState();
}

class _NumberAndAmountScreenState extends State<NumberAndAmountScreen> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _moneyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFieldWidget(
              controller: _phoneNumberController,
              hint: "Mobile Number",
            ),
            TextFieldWidget(
              controller: _moneyController,
              hint: "Lacagta",
            ),
            RaisedButton(
              color: Colors.black,
              onPressed: () async {
                await _makePhoneCall(
                    'tel:${widget.code}${_phoneNumberController.text}*${_moneyController.text}%23');
              },
              child: Text(
                "Bixi",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    await FlutterPhoneDirectCaller.callNumber(url);
  }
}
