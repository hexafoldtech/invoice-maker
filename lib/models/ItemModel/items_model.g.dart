// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemsModelAdapter extends TypeAdapter<ItemsModel> {
  @override
  final int typeId = 0;

  @override
  ItemsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemsModel(
      itemName: fields[0] as String,
      itemDetails: fields[1] as String,
      itemUnitPrice: fields[2] as double,
      itemQuantity: fields[3] as int,
      itemDiscount: fields[4] as double,
      itemTaxable: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ItemsModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.itemName)
      ..writeByte(1)
      ..write(obj.itemDetails)
      ..writeByte(2)
      ..write(obj.itemUnitPrice)
      ..writeByte(3)
      ..write(obj.itemQuantity)
      ..writeByte(4)
      ..write(obj.itemDiscount)
      ..writeByte(5)
      ..write(obj.itemTaxable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
