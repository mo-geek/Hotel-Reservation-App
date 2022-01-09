import 'package:booking_assessment/app/locator.dart';
import 'package:booking_assessment/core/models/hotelData.dart';
import 'package:booking_assessment/core/models/hotelRoom.dart';
import 'package:booking_assessment/core/models/userData.dart';
import 'package:booking_assessment/core/models/userRoom.dart';
import 'package:booking_assessment/core/services/bookingservice/booking_service_interface.dart';
import 'package:booking_assessment/core/services/database/mydb.dart';
import 'package:booking_assessment/core/services/entityservice/entityinterface.dart';
import 'package:booking_assessment/core/services/hotelservice/hotel_service_interface.dart';
import 'package:booking_assessment/core/services/roomservice/room_service_interface.dart';
import 'package:booking_assessment/core/services/userservice/user_service_interface.dart';

class FakeEntityRepository implements EntityServiceInterface {
  final db = locator<DataBase>();
  final hotels = locator<HotelServiceInterface>();
  final rooms = locator<RoomServiceInterface>();
  final users = locator<UserServiceInterface>();
  final BookingServiceInterface booking = locator<BookingServiceInterface>();

  @override
  Future addFakeData() async {
    await db.database;
    final hotel1 = Hotel(id: 1, name: 'Ellerman House');
    final hotel2 = Hotel(id: 2, name: 'The Langham Shanghai');
    hotels.addHotelBranch(hotel1);
    hotels.addHotelBranch(hotel2);
    final room1h1 = HotelRoom(
        type: RoomType.single, isBooked: false, hotel: 1, price: 20.0, id: 12);
    final room2h1 = HotelRoom(
        type: RoomType.double, isBooked: false, hotel: 1, price: 20.0, id: 13);
    final room1h2 = HotelRoom(
        type: RoomType.single, isBooked: false, hotel: 2, price: 20.0, id: 14);
    final room2h2 = HotelRoom(
        type: RoomType.double, isBooked: false, hotel: 2, price: 20.0, id: 15);
    final room3h2 = HotelRoom(
        type: RoomType.suite, isBooked: false, hotel: 2, price: 20.0, id: 16);
    rooms.addRoom(room1h1);
    rooms.addRoom(room2h1);
    rooms.addRoom(room1h2);
    rooms.addRoom(room2h2);
    rooms.addRoom(room3h2);
    const user1 = UserData(name: 'Ali', hasDiscount: false, id: 3);
    const user2 = UserData(name: 'Islam', hasDiscount: false, id: 7);
    users.addUser(user1);
    users.addUser(user2);
    print(user1.id);
    print(room1h1.id);
    final user1Rooms = UserRoom(idUser: user1.id!, idRoom: room1h2.id!);
    booking.addBooking(userRoom: user1Rooms);
  }
}
