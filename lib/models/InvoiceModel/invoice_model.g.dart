// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvoiceModelAdapter extends TypeAdapter<InvoiceModel> {
  @override
  final int typeId = 2;

  @override
  InvoiceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InvoiceModel(
      id: fields[0] as int,
      client: fields[1] as ClientsModel,
      dueDate: fields[2] as String,
      items: (fields[7] as List).cast<ItemsModel>(),
      discount: fields[4] as double,
      subTotal: fields[3] as double,
      tax: fields[5] as double?,
      taxType: fields[6] as String?,
      status: fields[9] as String,
      total: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, InvoiceModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.client)
      ..writeByte(2)
      ..write(obj.dueDate)
      ..writeByte(3)
      ..write(obj.subTotal)
      ..writeByte(4)
      ..write(obj.discount)
      ..writeByte(5)
      ..write(obj.tax)
      ..writeByte(6)
      ..write(obj.taxType)
      ..writeByte(7)
      ..write(obj.items)
      ..writeByte(8)
      ..write(obj.total)
      ..writeByte(9)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
