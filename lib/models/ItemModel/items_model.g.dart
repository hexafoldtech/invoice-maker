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
      id: fields[0] as int,
      itemName: fields[1] as String,
      itemDetails: fields[2] as String,
      itemUnitPrice: fields[3] as double,
      itemQuantity: fields[4] as int,
      itemDiscount: fields[5] as double,
      itemTaxable: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ItemsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.itemDetails)
      ..writeByte(3)
      ..write(obj.itemUnitPrice)
      ..writeByte(4)
      ..write(obj.itemQuantity)
      ..writeByte(5)
      ..write(obj.itemDiscount)
      ..writeByte(6)
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
