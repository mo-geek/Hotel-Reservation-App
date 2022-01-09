import 'package:booking_assessment/core/constants/constants.dart';
import 'package:booking_assessment/core/models/hotelData.dart';
import 'package:booking_assessment/core/models/hotelRoom.dart';
import 'package:booking_assessment/core/models/userData.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBase {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _createDB('DB21.db');
    return _database!;
  }

  Future<Database> _createDB(String dbFile) async {
    final dbDirectory = await getDatabasesPath();
    final finalDirec = join(dbDirectory, dbFile);
    return await openDatabase(finalDirec, version: 2, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    await db.execute(
        ' CREATE TABLE ${Constants.hotelTable} ( ${HotelFields.id} ${Constants.idType}, ${HotelFields.name} ${Constants.textType})');

    await db.execute(
        'CREATE TABLE ${Constants.roomsTable} ( ${RoomFields.id} ${Constants.idType}, ${RoomFields.price} ${Constants.textType}, ${RoomFields.type} ${Constants.textType}, ${RoomFields.hotel} ${Constants.integerType}, ${RoomFields.isBooked} ${Constants.boolType},  FOREIGN KEY (${RoomFields.hotel}) REFERENCES ${Constants.hotelTable}(${HotelFields.id}) )');

    await db.execute(
        'CREATE TABLE ${Constants.usersTable} ( ${UserFields.id} ${Constants.idType}, ${UserFields.name} ${Constants.textType}, ${UserFields.hasDiscount} ${Constants.boolType})');

    await db.execute(
        'CREATE TABLE ${Constants.userRoomsTable} ( ${RoomFields.id} ${Constants.integerType}, ${UserFields.id} ${Constants.integerType}, PRIMARY KEY (${RoomFields.id},${UserFields.id}), FOREIGN KEY (${RoomFields.id}) REFERENCES ${Constants.roomsTable} (${RoomFields.id}) ON DELETE CASCADE ON UPDATE NO ACTION, FOREIGN KEY (${UserFields.id}) REFERENCES ${Constants.usersTable} (${UserFields.id}) ON DELETE CASCADE ON UPDATE NO ACTION )');
  }

  Future? close() async {
    final db = await database;
    db.close();
  }
}
