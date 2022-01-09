import 'package:booking_assessment/app/locator.dart';
import 'package:booking_assessment/core/constants/constants.dart';
import 'package:booking_assessment/core/models/hotelData.dart';
import 'package:booking_assessment/core/services/database/mydb.dart';
import 'hotel_service_interface.dart';

class HotelRepository implements HotelServiceInterface {
  final dbInstance = locator<DataBase>();

  @override
  Future<Hotel?> addHotelBranch(Hotel hotel) async {
    final db = await dbInstance.database;
    final id = await db.insert(Constants.hotelTable, hotel.toJson());
    hotel.copy(id: id);
  }

  @override
  Future<Hotel> readHotelFromDB(int id) async {
    final db = await dbInstance.database;
    final map = await db.query(
      Constants.hotelTable,
      columns: HotelFields.getHotelFields,
      where: '${HotelFields.id} = ?',
      whereArgs: [id],
    );
    if (map.isNotEmpty) {
      return Hotel.fromJson(map.first);
    } else {
      throw 'Could n\'t find Hotel with this $id';
    }
  }

  @override
  Future<List<Hotel>> readAllHotelsFromDB() async {
    final db = await dbInstance.database;
    final mapList = await db.query(Constants.hotelTable);
    print('hotel map: $mapList');
    return mapList.map((e) => Hotel.fromJson(e)).toList();
  }

  @override
  Future<int> updateHotelInDB(Hotel hotel) async {
    final db = await dbInstance.database;
    return await db.update(Constants.hotelTable, hotel.toJson(),
        where: '${HotelFields.id} = ?', whereArgs: [hotel.id]);
  }
}
