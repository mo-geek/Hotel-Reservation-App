import 'package:booking_assessment/core/models/hotelData.dart';

abstract class HotelServiceInterface {
  Future<Hotel?> addHotelBranch(Hotel hotel);
  Future<Hotel> readHotelFromDB(int id);
  Future<List<Hotel>> readAllHotelsFromDB();
  Future<int> updateHotelInDB(Hotel hotel);
}
