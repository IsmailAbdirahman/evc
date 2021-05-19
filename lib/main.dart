import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CardSelector(),
    );
  }
}

class CardSelector extends StatefulWidget {
  String ogowHraa = "*711%23";
  String kushuboLcg = "*713%23";

  @override
  _CardSelectorState createState() => _CardSelectorState();
}

class _CardSelectorState extends State<CardSelector> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.greenAccent[100],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EvcScreen1(
                                code: "*712*",
                              )));
                },
                child: cardWidget("Bixi Lacag:       *712*")),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EvcScreen1(
                                code: "*789*",
                              )));
                },
                child: cardWidget("Bixi Lacag:       *789*")),
            GestureDetector(
                onTap: () {
                  _knowPalance('tel: ${widget.ogowHraa}');
                },
                child: cardWidget("Ogoow Haraagaga:    *711#")),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EvcScreen1(
                                code: "*713*",
                              )));
                },
                child: cardWidget("Ku Shubo Lacag:       *713*"))
          ],
        ),
      ),
    );
  }

  Widget cardWidget(String value) {
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
            value,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
          )),
        ),
      ),
    );
  }

  Future<void> _knowPalance(String url) async {
    await FlutterPhoneDirectCaller.callNumber(url);
  }
}

class EvcScreen1 extends StatefulWidget {
  final String code;

  EvcScreen1({this.code});

  @override
  _EvcScreen1State createState() => _EvcScreen1State();
}

class _EvcScreen1State extends State<EvcScreen1> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _moneyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
                decoration: inputDecoration(hintName: "Mobile Number ka"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: TextField(
                controller: _moneyController,
                keyboardType: TextInputType.phone,
                decoration: inputDecoration(hintName: "Lacagta"),
              ),
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

  InputDecoration inputDecoration({String hintName}) {
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.black)),
        border: OutlineInputBorder(),
        hintText: hintName,
        hintStyle: TextStyle(color: Colors.black54));
  }
}
