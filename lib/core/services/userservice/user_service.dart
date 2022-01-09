import 'package:booking_assessment/app/locator.dart';
import 'package:booking_assessment/core/constants/constants.dart';
import 'package:booking_assessment/core/models/userData.dart';
import 'package:booking_assessment/core/services/database/mydb.dart';
import 'package:booking_assessment/core/services/userservice/user_service_interface.dart';

class UserRepository implements UserServiceInterface {
  final dbInstance = locator<DataBase>();

  @override
  Future addUser(UserData user) async {
    final db = await dbInstance.database;
    final id = await db.insert(Constants.usersTable, user.toJson());
    user.copy(id: id);
  }

  @override
  Future<UserData> readUserFromDB(int id) async {
    final db = await dbInstance.database;
    final map = await db.query(
      Constants.usersTable,
      columns: UserFields.getUserFields,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
    if (map.isNotEmpty) {
      return UserData.fromJson(map.first);
    } else {
      throw 'Could n\'t find User with this $id';
    }
  }

  @override
  Future<List<UserData>> readAllUsersFromDB() async {
    final db = await dbInstance.database;
    final mapList = await db.query(Constants.usersTable);
    return mapList.map((e) => UserData.fromJson(e)).toList();
  }

  @override
  Future<int> updateUserInDB(UserData userData) async {
    final db = await dbInstance.database;
    return await db.update(Constants.usersTable, userData.toJson(),
        where: '${UserFields.id} = ?', whereArgs: [userData.id]);
  }

  @override
  Future<int> deleteUserInDB(int userID) async {
    final db = await dbInstance.database;
    return await db.delete(Constants.usersTable,
        where: '${UserFields.id} = ?', whereArgs: [userID]);
  }
}
