// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class BookingAdapter extends TypeAdapter<Booking> {
  @override
  final typeId = 0;

  @override
  Booking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Booking(
      event: fields[0] as Event,
      package: fields[1] as Package,
      name: fields[2] as String,
      phoneEmail: fields[3] as String,
      peopleAmountC: (fields[4] as num).toInt(),
      date: fields[5] as DateTime,
      addTransport: fields[6] as bool,
      addMeal: fields[7] as bool,
      basePrice: (fields[8] as num).toDouble(),
      perPersonTotal: (fields[9] as num).toDouble(),
      transportTotal: (fields[10] as num).toDouble(),
      mealTotal: (fields[11] as num).toDouble(),
      subTotal: (fields[12] as num).toDouble(),
      discount: (fields[13] as num).toDouble(),
      total: (fields[14] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Booking obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.event)
      ..writeByte(1)
      ..write(obj.package)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.phoneEmail)
      ..writeByte(4)
      ..write(obj.peopleAmountC)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.addTransport)
      ..writeByte(7)
      ..write(obj.addMeal)
      ..writeByte(8)
      ..write(obj.basePrice)
      ..writeByte(9)
      ..write(obj.perPersonTotal)
      ..writeByte(10)
      ..write(obj.transportTotal)
      ..writeByte(11)
      ..write(obj.mealTotal)
      ..writeByte(12)
      ..write(obj.subTotal)
      ..writeByte(13)
      ..write(obj.discount)
      ..writeByte(14)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EventAdapter extends TypeAdapter<Event> {
  @override
  final typeId = 1;

  @override
  Event read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Event(
      name: fields[0] as String,
      desc: fields[1] as String,
      img: fields[2] as String,
      info: fields[3] as String,
      package: (fields[4] as List).cast<Package>(),
    );
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.desc)
      ..writeByte(2)
      ..write(obj.img)
      ..writeByte(3)
      ..write(obj.info)
      ..writeByte(4)
      ..write(obj.package);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PackageAdapter extends TypeAdapter<Package> {
  @override
  final typeId = 2;

  @override
  Package read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Package(
      title: fields[0] as String,
      desc: fields[1] as String,
      basePrice: (fields[2] as num).toDouble(),
      perPerson: (fields[3] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Package obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.desc)
      ..writeByte(2)
      ..write(obj.basePrice)
      ..writeByte(3)
      ..write(obj.perPerson);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
