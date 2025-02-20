// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clients_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientsModelAdapter extends TypeAdapter<ClientsModel> {
  @override
  final int typeId = 0;

  @override
  ClientsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientsModel(
      id: fields[0] as int,
      clientName: fields[1] as String,
      clientPhoneNumber: fields[2] as String,
      clientEmail: fields[3] as String,
      clientAddress: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ClientsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.clientName)
      ..writeByte(2)
      ..write(obj.clientPhoneNumber)
      ..writeByte(3)
      ..write(obj.clientEmail)
      ..writeByte(4)
      ..write(obj.clientAddress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
