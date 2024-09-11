import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'parcels.g.dart';

@HiveType(typeId: 1)
class Parcels {
  @HiveField(0)
  String? status;
  @HiveField(1)
  String? productNameController;
  @HiveField(2)
  String? productWeightController;
  @HiveField(3)
  String? typeOfGoodsController;
  @HiveField(4)
  String? dateOfReceiptOfgoodsController;
  @HiveField(5)
  String? productIdController;
  Parcels(
      {this.status,
      this.productNameController,
      this.productWeightController,
      this.typeOfGoodsController,
      this.dateOfReceiptOfgoodsController,
      this.productIdController});
}
