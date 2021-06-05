import 'package:evcapp/app_states/number_amount_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_states/stores_location_state.dart';
import 'common/text_field_widegtt.dart';
import 'package:clipboard/clipboard.dart';

class NumberAndAmountScreen extends StatefulWidget {
  final String? code;

  NumberAndAmountScreen({this.code});

  @override
  _NumberAndAmountScreenState createState() => _NumberAndAmountScreenState();
}

class _NumberAndAmountScreenState extends State<NumberAndAmountScreen> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _moneyController = TextEditingController();
  final snackBar = SnackBar(content: Text("Mobile Number is Copied"));

  @override
  void initState() {
    super.initState();
    initLocationPermission();
  }

  initLocationPermission() async {
    await context.read(storesLocationProvider).checkLocationPermission();
    await context.read(storesLocationProvider).getClosestLocationPhoneNumber();
    if (context.read(storesLocationProvider).isCurrentLocationAvailable) {
      popUpDialog(context);
    }
  }

  popUpDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Goobtan Horay ayaad wax ooga iib satay, Mobile Numberkoda waa kuwa hoos ku xusan Mid ka mid ah.",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            content: listOfNumbersInDialog(),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }

  listOfNumbersInDialog() {
    return Container(
        height: 160,
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
                        return InkWell(
                          onTap: () {
                            FlutterClipboard.copy(snapshot.data![index])
                                .then((value) => print('copied'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            FlutterClipboard.paste().then((value) {
                              setState(() {
                                _phoneNumberController.text = value;
                              });
                            });
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data![index],
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30,
                                  letterSpacing: 1.2),
                            ),
                          ),
                        );
                      }),
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
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
                    context
                        .read(storesLocationProvider)
                        .addCurrentLocationToDatabase(
                            lati: locationProvider.latitude,
                            longi: locationProvider.longitude,
                            phoneNO: _phoneNumberController.text);
                    await context.read(numberAmountStateProvider).makePhoneCall(
                        'tel:${widget.code}${_phoneNumberController.text}*${_moneyController.text}%23');
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
