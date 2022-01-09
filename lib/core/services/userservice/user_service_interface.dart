import 'package:booking_assessment/core/models/userData.dart';

abstract class UserServiceInterface {
  Future addUser(UserData user);

  Future<UserData> readUserFromDB(int id);

  Future<List<UserData>> readAllUsersFromDB();

  Future<int> updateUserInDB(UserData userData);

  Future<int> deleteUserInDB(int userID);
}
