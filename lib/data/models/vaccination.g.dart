// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccination.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VaccinationAdapter extends TypeAdapter<Vaccination> {
  @override
  final int typeId = 2;

  @override
  Vaccination read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vaccination(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Vaccination obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.numberDoses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaccinationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
