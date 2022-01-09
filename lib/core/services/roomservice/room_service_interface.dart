import 'package:booking_assessment/core/models/hotelRoom.dart';

abstract class RoomServiceInterface {
  Future addRoom(HotelRoom room);
  Future<HotelRoom> readRoomFromDB(int id);
  Future<List<HotelRoom>> readAllRoomsFromDB();
  Future<List<HotelRoom>> readHotelRoomsFromDB({required int hotelID});
  Future<int> updateRoomInDB(HotelRoom hotelRoom);
  Future<int> deleteRoomInDB(int roomID);
}
