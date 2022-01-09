import 'package:booking_assessment/core/services/bookingservice/booking_service.dart';
import 'package:booking_assessment/core/services/bookingservice/booking_service_interface.dart';
import 'package:booking_assessment/core/services/entityservice/entity.dart';
import 'package:booking_assessment/core/services/database/mydb.dart';
import 'package:booking_assessment/core/services/entityservice/entityinterface.dart';
import 'package:booking_assessment/core/services/hotelservice/hotel_service.dart';
import 'package:booking_assessment/core/services/hotelservice/hotel_service_interface.dart';
import 'package:booking_assessment/core/services/roomservice/room_service.dart';
import 'package:booking_assessment/core/services/roomservice/room_service_interface.dart';
import 'package:booking_assessment/core/services/userservice/user_service.dart';
import 'package:booking_assessment/core/services/userservice/user_service_interface.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.asNewInstance();

void setupLocator() {
  // locate the app services in the main func.
  locator.registerLazySingleton<HotelServiceInterface>(() => HotelRepository());
  locator.registerLazySingleton<RoomServiceInterface>(() => RoomRepository());
  locator.registerLazySingleton<UserServiceInterface>(() => UserRepository());
  locator.registerLazySingleton(() => DataBase());
  locator
      .registerLazySingleton<BookingServiceInterface>(() => BookingRepository());
  locator
      .registerLazySingleton<EntityServiceInterface>(() => FakeEntityRepository());
}
