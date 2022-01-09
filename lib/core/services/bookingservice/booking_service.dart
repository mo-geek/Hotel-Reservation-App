import 'package:booking_assessment/app/locator.dart';
import 'package:booking_assessment/core/constants/constants.dart';
import 'package:booking_assessment/core/models/hotelRoom.dart';
import 'package:booking_assessment/core/models/userRoom.dart';
import 'package:booking_assessment/core/services/bookingservice/booking_service_interface.dart';
import 'package:booking_assessment/core/services/database/mydb.dart';

class BookingRepository implements BookingServiceInterface {
  final dbInstance = locator<DataBase>();

  @override
  Future addBooking({required UserRoom userRoom}) async {
    final db = await dbInstance.database;
    await db.insert(Constants.userRoomsTable, userRoom.toJson());
  }

  @override
  Future<List<UserRoom>> readAllBookingFromDB() async {
    final db = await dbInstance.database;
    final mapList = await db.query(Constants.userRoomsTable);
    return mapList.map((e) => UserRoom.fromJson(e)).toList();
  }

  @override
  Future<UserRoom> readBookingFromDB(int userId) async {
    final db = await dbInstance.database;
    final map = await db.query(
      Constants.userRoomsTable,
      columns: UserRoomFields.getUserRoomFields,
      where: '${UserRoomFields.idUser} = ?',
      whereArgs: [userId],
    );
    if (map.isNotEmpty) {
      return UserRoom.fromJson(map.first);
    } else {
      throw 'Could n\'t find UserRoom relation with this $userId';
    }
  }

  @override
  Future<int> updateBookingInDB({required UserRoom userRoom}) async {
    final db = await dbInstance.database;
    return await db.update(Constants.userRoomsTable, userRoom.toJson(),
        where: '${UserRoomFields.idUser} = ? AND ${UserRoomFields.idRoom} = ?',
        whereArgs: [userRoom.idUser, userRoom.idRoom]);
  }

  @override
  Future<int> deleteBookingInDB({required UserRoom userRoom}) async {
    final db = await dbInstance.database;
    return await db.delete(Constants.userRoomsTable,
        where: '${UserRoomFields.idRoom} = ? AND ${UserRoomFields.idUser} = ?',
        whereArgs: [userRoom.idRoom, userRoom.idUser]);
  }
}
