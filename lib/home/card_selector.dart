import 'package:evcapp/common/button_names_staring.dart';
import 'package:evcapp/common/card_button.dart';
import 'package:evcapp/service/stores_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import '../number_and_amount_screen.dart';

class CardSelector extends StatefulWidget {
  @override
  _CardSelectorState createState() => _CardSelectorState();
}

class _CardSelectorState extends State<CardSelector> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.greenAccent[400],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                          builder: (BuildContext context) =>
                              NumberAndAmountScreen(
                                code: PAY_AMOUNT_CODE,
                              )));
                },
                child: CardButton(
                    code: PAY_AMOUNT_CODE, buttonText: PAY_AMOUNT_TEXT)),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              NumberAndAmountScreen(
                                code: MERCHANT_CODE,
                              )));
                },
                child: CardButton(
                    code: MERCHANT_CODE, buttonText: MERCHANT_BUTTON_TEXT)),
            GestureDetector(
                onTap: () {
                  _knowBalance('tel: *711%23');
                },
                child: CardButton(
                    code: KNOW_BALANCE_CODE, buttonText: KNOW_BALANCE_TEXT)),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              NumberAndAmountScreen(
                                code: ADD_MONEY_CODE,
                              )));
                },
                child: CardButton(
                    code: ADD_MONEY_CODE, buttonText: ADD_MONEY_TEXT))
          ],
        ),
      ),
    );
  }

  Future<void> _knowBalance(String url) async {
    await FlutterPhoneDirectCaller.callNumber(url);
  }
}
