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
      issueDate: fields[2] as DateTime,
      dueDate: fields[3] as DateTime,
      items: (fields[8] as List).cast<ItemsModel>(),
      discount: fields[5] as double,
      subTotal: fields[4] as double,
      tax: fields[6] as double?,
      taxType: fields[7] as String?,
      status: fields[10] as String,
      total: fields[9] as double,
      paidAmount: fields[11] as double,
    );
  }

  @override
  void write(BinaryWriter writer, InvoiceModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.client)
      ..writeByte(2)
      ..write(obj.issueDate)
      ..writeByte(3)
      ..write(obj.dueDate)
      ..writeByte(4)
      ..write(obj.subTotal)
      ..writeByte(5)
      ..write(obj.discount)
      ..writeByte(6)
      ..write(obj.tax)
      ..writeByte(7)
      ..write(obj.taxType)
      ..writeByte(8)
      ..write(obj.items)
      ..writeByte(9)
      ..write(obj.total)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.paidAmount);
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
