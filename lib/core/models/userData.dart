import 'package:booking_assessment/core/models/hotelRoom.dart';

class UserFields {
  static List<String> getUserFields = [id, name, hasDiscount];
  static const String id = 'UserId';
  static const String name = 'Name';
  // static const String bookedRooms = 'BookedRooms';
  static const String hasDiscount = 'HasDiscount';
}

class UserData {
  final int? id;
  final String name;
  // final List<HotelRoom> bookedRooms;
  final bool hasDiscount;

  const UserData({
    this.id,
    required this.name,
    // this.bookedRooms,
    required this.hasDiscount,
  });

  UserData copy({
    int? id,
    String? name,
    bool? hasDiscount,
  }) =>
      UserData(
        id: id ?? this.id,
        name: name ?? this.name,
        hasDiscount: hasDiscount ?? this.hasDiscount,
      );

  static UserData fromJson(Map<String, Object?> map) => UserData(
        id: int.tryParse(map[UserFields.id].toString()),
        name: map[UserFields.name] as String,
        hasDiscount: map[UserFields.hasDiscount] == 1,
      );

  Map<String, Object?> toJson() {
    var map = <String, Object?>{};
    // final listBookedRooms =
    //     List<dynamic>.from(bookedRooms.map((e) => e.toJson()));
    map = {
      UserFields.id: id,
      UserFields.name: name,
      // UserFields.bookedRooms: listBookedRooms.toString(),
      UserFields.hasDiscount: hasDiscount ? 1 : 0
    };
    return map;
  }
}
