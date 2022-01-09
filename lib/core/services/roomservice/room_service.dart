import 'package:booking_assessment/app/locator.dart';
import 'package:booking_assessment/core/constants/constants.dart';
import 'package:booking_assessment/core/models/hotelRoom.dart';
import 'package:booking_assessment/core/services/database/mydb.dart';
import 'package:booking_assessment/core/services/roomservice/room_service_interface.dart';

class RoomRepository implements RoomServiceInterface {
  final dbInstance = locator<DataBase>();
  @override
  Future addRoom(HotelRoom room) async {
    final db = await dbInstance.database;
    final id = await db.insert(Constants.roomsTable, room.toJson());
    room.copy(id: id);
  }

  @override
  Future<HotelRoom> readRoomFromDB(int id) async {
    final db = await dbInstance.database;
    final map = await db.query(
      Constants.roomsTable,
      columns: RoomFields.getRoomFields,
      where: '${RoomFields.id} = ?',
      whereArgs: [id],
    );
    if (map.isNotEmpty) {
      return HotelRoom.fromJson(map.first);
    } else {
      throw 'Could n\'t find Hotel Room with this $id';
    }
  }

  @override
  Future<List<HotelRoom>> readHotelRoomsFromDB({required int hotelID}) async {
    final db = await dbInstance.database;
    final map = await db.query(
      Constants.roomsTable,
      columns: RoomFields.getRoomFields,
      where: '${RoomFields.hotel} = ?',
      whereArgs: [hotelID],
    );
    if (map.isNotEmpty) {
      print('hotel rooms: $map');
      return map.map((e) => HotelRoom.fromJson(e)).toList();
    } else {
      throw 'Could n\'t find Hotel Rooms with this hotel $hotelID';
    }
  }

  @override
  Future<List<HotelRoom>> readAllRoomsFromDB() async {
    final db = await dbInstance.database;
    final mapList = await db.query(Constants.roomsTable);
    return mapList.map((e) => HotelRoom.fromJson(e)).toList();
  }

  @override
  Future<int> updateRoomInDB(HotelRoom hotelRoom) async {
    final db = await dbInstance.database;
    return await db.update(Constants.roomsTable, hotelRoom.toJson(),
        where: '${RoomFields.id} = ?', whereArgs: [hotelRoom.id]);
  }

  @override
  Future<int> deleteRoomInDB(int roomID) async {
    final db = await dbInstance.database;
    return await db.delete(Constants.roomsTable,
        where: '${RoomFields.id} = ?', whereArgs: [roomID]);
  }
}
