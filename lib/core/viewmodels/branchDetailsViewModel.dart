import 'package:booking_assessment/app/locator.dart';
import 'package:booking_assessment/core/models/hotelRoom.dart';
import 'package:booking_assessment/core/models/userData.dart';
import 'package:booking_assessment/core/models/userRoom.dart';
import 'package:booking_assessment/core/services/bookingservice/booking_service_interface.dart';
import 'package:booking_assessment/core/services/roomservice/room_service_interface.dart';
import 'package:booking_assessment/core/services/userservice/user_service_interface.dart';
import 'package:booking_assessment/ui/shared/commonWidgets/toastShow.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class BranchDetailsViewModel extends BaseViewModel {
  List<HotelRoom> _list = <HotelRoom>[];
  List<HotelRoom> get hotelRoomsList => _list;

  List<HotelRoom> _userList = <HotelRoom>[];
  List<HotelRoom> get userRoomsList => _userList;

  final rooms = locator<RoomServiceInterface>();
  final users = locator<UserServiceInterface>();
  final booking = locator<BookingServiceInterface>();

  Future<dynamic> allHotelRoomsFromDB(
      {required int hotelID, required int userId}) async {
    var roomsData = await rooms.readHotelRoomsFromDB(hotelID: hotelID);
    final bookingData = await booking.readAllBookingFromDB();
    // get all rooms including user reservation roomsIncludingBooked

    List<HotelRoom> allRoomsIncludingBooked = [];
    List<HotelRoom> allUserRooms = [];
    for (var element in roomsData) {
      bool reserve = await _checkForReservation(
          UserRoom(idUser: userId, idRoom: element.id!));
      bool? sameUserRoom = await _bookingSameRoom(
          UserRoom(idUser: userId, idRoom: element.id!));
      // true means, room is full or user has reserved
      bool booked = bookingData.where((e) => !reserve).toList().isNotEmpty;
      if (booked) {
        element = element.copy(isBooked: true);
      }
      allRoomsIncludingBooked.add(element);
      if (sameUserRoom!){
        allUserRooms.add(element);
      }
    }
    _list = allRoomsIncludingBooked;
    _userList = allUserRooms;
    print('rooms in the list: $_list');
  }

  // check if we can reserve room twice,
  // check if the room is already full,
  // check if the user booking the same room,

  Future<bool?> _bookingSameRoom(UserRoom? userRoom) async {
    final data = await booking.readAllBookingFromDB();
    bool userBookingSameRoom = data
        .where((element) =>
            element.idUser == userRoom?.idUser &&
            element.idRoom == userRoom?.idRoom)
        .isNotEmpty;
    if (userBookingSameRoom) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> _notValidForBooking(UserRoom? userRoom) async {
    final bookingData = await booking.readAllBookingFromDB();
    final roomsData = await rooms.readAllRoomsFromDB();
    HotelRoom? room =
        roomsData.firstWhere((element) => element.id == userRoom?.idRoom);
    int reservedTimes = bookingData
        .where((element) => element.idRoom == userRoom?.idRoom)
        .toList()
        .length;
    if (reservedTimes == 1 && room.type == RoomType.single) {
      return true;
    }
    if (reservedTimes == 2 &&
        (room.type == RoomType.suite || room.type == RoomType.double)) {
      return true;
    }
    return false;
  }

  Future<bool> _checkForReservation(UserRoom? userRoom) async {
    // true means room is reserved for the same user
    final sameRoomCheck = await _bookingSameRoom(userRoom);
    print('sameRoomCheck: $sameRoomCheck');
    // true means the room (double, suite, single) is already full
    final alreadyReserved = await _notValidForBooking(userRoom);
    print('alreadyReserved: $alreadyReserved');

    return !sameRoomCheck! && !alreadyReserved!;
  }

  Future<bool> checkRoomReserved({UserRoom? userRoom}) async {
    final bookingReport = await booking.readAllBookingFromDB();
    return bookingReport
        .where((element) =>
            element.idRoom == userRoom?.idRoom &&
            element.idUser == userRoom?.idUser)
        .toList()
        .isNotEmpty;
  }

  Future<dynamic> updateBookingInDB(BuildContext context,
      {UserRoom? userRoom, required int hotelID}) async {
    print('updateBookingInDB');
    final bookingReport = await booking.readAllBookingFromDB();
    print('bookingReport: $bookingReport');
    bool reserve = await _checkForReservation(userRoom);
    print('reserve status: $reserve');
    // if true it means you can reserve the room for the selected user
    if (reserve) {
      await booking.addBooking(userRoom: userRoom!);
      await allHotelRoomsFromDB(hotelID: hotelID, userId: userRoom.idUser);
      notifyListeners();
      ShowMessage.showToast('wish you good time!');
    } else {
      ShowMessage.showToast('booking is not valid');
    }
  }

  Future<dynamic> cancelBookingInDB({UserRoom? userRoom, int? hotelID}) async {
    final sameRoomCheck = await _bookingSameRoom(userRoom!);

    if (sameRoomCheck!) {
      await booking.deleteBookingInDB(userRoom: userRoom);
      await allHotelRoomsFromDB(hotelID: hotelID!, userId: userRoom.idUser);
      notifyListeners();
      ShowMessage.showToast('your booking is canceled!');
    }
  }
}
