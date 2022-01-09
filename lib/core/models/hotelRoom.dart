import 'hotelData.dart';

enum RoomType { single, double, suite }

class RoomFields {
  static List<String> getRoomFields = [id, type, isBooked, hotel, price];
  static const String id = 'RoomId';
  static const String type = 'RoomType';
  static const String isBooked = 'IsBooked';
  static const String hotel = 'HotelId';
  static const String price = 'RoomPrice';
}

class HotelRoom {
  final int? id;
  final RoomType type;
  final bool isBooked;
  final int hotel;
  final double price;

  HotelRoom({
    this.id,
    required this.type,
    required this.isBooked,
    required this.hotel,
    required this.price,
  });

  HotelRoom copy({
    int? id,
    RoomType? type,
    bool? isBooked,
    int? hotel,
    double? price,
  }) =>
      HotelRoom(
        id: id ?? this.id,
        type: type ?? this.type,
        isBooked: isBooked ?? this.isBooked,
        hotel: hotel ?? this.hotel,
        price: price ?? this.price,
      );

  static HotelRoom fromJson(Map<String, Object?> map) {
    return HotelRoom(
      id: int.tryParse(map[RoomFields.id].toString()),
      type: getRoomType(map[RoomFields.type].toString()),
      isBooked: map[RoomFields.isBooked] == 1,
      hotel: int.parse(map[RoomFields.hotel].toString()),
      price: double.parse(map[RoomFields.price].toString()),
    );
  }

  Map<String, Object?> toJson() {
    var map = <String, Object?>{};
    map = {
      RoomFields.hotel: hotel.toString(),
      RoomFields.isBooked: isBooked ? 1 : 0,
      RoomFields.type: type.toString(),
      RoomFields.price: price.toString(),
      RoomFields.id: id,
    };

    return map;
  }

  static RoomType getRoomType(String rt) {
    switch (rt) {
      case 'RoomType.single':
        return RoomType.single;
      case 'RoomType.double':
        return RoomType.double;
      case 'RoomType.suite':
        return RoomType.suite;
      default:
        return RoomType.single;
    }
  }
}
