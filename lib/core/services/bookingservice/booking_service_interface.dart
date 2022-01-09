import 'package:booking_assessment/core/models/userRoom.dart';

abstract class BookingServiceInterface {
  Future addBooking({required UserRoom userRoom});
  Future<UserRoom> readBookingFromDB(int userId);
  Future<List<UserRoom>> readAllBookingFromDB();
  Future<int> updateBookingInDB({required UserRoom userRoom});
  Future<int> deleteBookingInDB({required UserRoom userRoom});
}
