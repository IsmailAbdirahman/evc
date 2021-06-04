import 'package:evcapp/app_states/number_amount_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_states/stores_location_state.dart';
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
  void initState() {
    super.initState();
    initLocationPermission();

    Future.delayed(Duration.zero, () {
      popUpDialog(context);
    });
  }

  initLocationPermission() async {
    await context.read(storesLocationProvider).checkLocationPermission();
    //await context.read(storesLocationProvider).getClosestLocationPhoneNumber();
  }

  popUpDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Mobile Numbers near by"),
            content: listOfNumbersInDialog(),
          );
        });
  }

  listOfNumbersInDialog() {
    return Container(
        height: 300,
        width: 300,
        child: FutureBuilder<List<String>>(
            future: context
                .read(storesLocationProvider)
                .getClosestLocationPhoneNumber(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                return Container(
                  height: 300,
                  width: 300,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(snapshot.data![index]);
                      }),
                );
              }
              return Center(child: CircularProgressIndicator());
            })
    );
  }

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
              textInputType: TextInputType.number,
            ),
            TextFieldWidget(
              controller: _moneyController,
              hint: "Lacagta",
              textInputType: TextInputType.phone,
            ),
            Consumer(
              builder: (context, watch, child) {
                final locationProvider = watch(storesLocationProvider);
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () async {
                    await locationProvider.getCurrentLocation();
                    await context.read(numberAmountStateProvider).makePhoneCall(
                        'tel:${widget.code}${_phoneNumberController
                            .text}*${_moneyController.text}%23');
                    context
                        .read(storesLocationProvider)
                        .addCurrentLocationToDatabase(
                        lati: locationProvider.latitude,
                        longi: locationProvider.longitude,
                        phoneNO: _phoneNumberController.text);
                  },
                  child: Text(
                    "Bixi",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
