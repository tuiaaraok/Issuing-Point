// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcels.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParcelsAdapter extends TypeAdapter<Parcels> {
  @override
  final int typeId = 1;

  @override
  Parcels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Parcels(
      status: fields[0] as String?,
      productNameController: fields[1] as String?,
      productWeightController: fields[2] as String?,
      typeOfGoodsController: fields[3] as String?,
      dateOfReceiptOfgoodsController: fields[4] as String?,
      productIdController: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Parcels obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.productNameController)
      ..writeByte(2)
      ..write(obj.productWeightController)
      ..writeByte(3)
      ..write(obj.typeOfGoodsController)
      ..writeByte(4)
      ..write(obj.dateOfReceiptOfgoodsController)
      ..writeByte(5)
      ..write(obj.productIdController);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParcelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
