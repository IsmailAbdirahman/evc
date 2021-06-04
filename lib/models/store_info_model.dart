import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'store_info_model.g.dart';

@HiveType(typeId: 1)
class StoreModel {
  @HiveField(0)
  String? mobileNumber;

  @HiveField(1)
  double? latitude;

  @HiveField(2)
  double? longitude;

  StoreModel({this.mobileNumber, this.latitude, this.longitude});
}
