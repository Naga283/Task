// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemsListAdapter extends TypeAdapter<ItemsList> {
  @override
  final int typeId = 1;

  @override
  ItemsList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemsList(
      items: (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ItemsList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemsListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
