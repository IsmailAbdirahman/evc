import 'package:evcapp/models/store_info_model.dart';
import 'package:evcapp/service/stores_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home/card_selector.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

const String STORE_INFO = "storedata";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StoreModelAdapter());
  Hive.openBox<StoreModel>(STORE_INFO);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CardSelector(),
    );
  }
}


