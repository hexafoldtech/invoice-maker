// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimate_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EstimateModelAdapter extends TypeAdapter<EstimateModel> {
  @override
  final int typeId = 3;

  @override
  EstimateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EstimateModel(
      id: fields[0] as int,
      client: fields[1] as ClientsModel,
      issueDate: fields[2] as DateTime,
      items: (fields[7] as List).cast<ItemsModel>(),
      discount: fields[4] as double,
      subTotal: fields[3] as double,
      tax: fields[5] as double?,
      taxType: fields[6] as String?,
      total: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, EstimateModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.client)
      ..writeByte(2)
      ..write(obj.issueDate)
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
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EstimateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
