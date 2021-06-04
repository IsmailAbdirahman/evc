import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final numberAmountStateProvider =
    ChangeNotifierProvider<NumberAmountState>((ref) {
  return NumberAmountState();
});

class NumberAmountState extends ChangeNotifier {
  Future<void> makePhoneCall(String url) async {
    await FlutterPhoneDirectCaller.callNumber(url);
  }
}
