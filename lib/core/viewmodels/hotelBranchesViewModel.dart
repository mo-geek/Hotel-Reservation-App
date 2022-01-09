import 'package:booking_assessment/app/locator.dart';
import 'package:booking_assessment/core/models/hotelData.dart';
import 'package:booking_assessment/core/models/userData.dart';
import 'package:booking_assessment/core/services/entityservice/entityinterface.dart';
import 'package:booking_assessment/core/services/hotelservice/hotel_service_interface.dart';
import 'package:booking_assessment/core/services/userservice/user_service_interface.dart';
import 'package:stacked/stacked.dart';

class HotelBranchesViewModel extends BaseViewModel {
  List<Hotel> _listH = <Hotel>[];
  List<Hotel> get hotelList => _listH;

  List<UserData> _listU = <UserData>[];
  List<UserData> get userList => _listU;

  UserData? _selectedUser;
  UserData? get selectedUser => _selectedUser;
  int? _selectedUserId;
  int? get selectedUserId => _selectedUserId;
  selectUser(int v) {
    _selectedUser = userList.firstWhere((element) => element.id == v);
    _selectedUserId = v;
    notifyListeners();
  }

  bool fetchedData = false;

  final users = locator<UserServiceInterface>();
  final hotels = locator<HotelServiceInterface>();
  final entity = locator<EntityServiceInterface>();

  Future<dynamic> _allHotelsFromDB() async {
    final data = await hotels.readAllHotelsFromDB();
    print('h: $data');
    _listH = data;
  }

  Future<dynamic> _allUsersFromDB() async {
    final data = await users.readAllUsersFromDB();
    _listU = data;
    print('l: $data');
  }

  Future<dynamic> fetchHomeScreenData() async {
    await _allHotelsFromDB();
    await _allUsersFromDB();
  }

  Future generateDefaultData() async {
    await entity.addFakeData();
    fetchedData = true;
    notifyListeners();
  }
}
