import 'package:booking_assessment/core/models/hotelRoom.dart';

class HotelFields {
  static List<String> getHotelFields = [id, name];
  static const String id = 'HotelId';
  static const String name = 'Name';
}

class Hotel {
  final int id;
  final String name;
  // final List<HotelRoom> rooms;

  Hotel({
    required this.id,
    required this.name,
    // this.rooms,
  });

  Hotel copy({int? id, String? name}) => Hotel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  static Hotel fromJson(Map<String, Object?> map) => Hotel(
        id: map[HotelFields.id] as int,
        name: map[HotelFields.name] as String,
      );

  Map<String, Object?> toJson() {
    var map = <String, Object?>{};
    map = {
      HotelFields.id: id,
      HotelFields.name: name,
    };
    return map;
  }
}
