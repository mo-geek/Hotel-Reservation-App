import 'package:booking_assessment/core/models/hotelData.dart';
import 'package:booking_assessment/core/models/hotelRoom.dart';
import 'package:booking_assessment/core/models/userData.dart';
import 'package:booking_assessment/core/models/userRoom.dart';
import 'package:booking_assessment/core/viewmodels/branchDetailsViewModel.dart';
import 'package:booking_assessment/ui/shared/commonViews/roomsItemsCard.dart';
import 'package:booking_assessment/ui/shared/commonWidgets/toastShow.dart';
import 'package:booking_assessment/ui/shared/commonWidgets/waitplease.dart';
import 'package:booking_assessment/ui/shared/style/colors.dart';
import 'package:booking_assessment/ui/shared/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';

class HotelRoomScreen extends StatefulWidget {
  final Hotel hotel;
  final UserData? selectedUser;
  const HotelRoomScreen({Key? key, required this.hotel, this.selectedUser})
      : super(key: key);

  @override
  _HotelRoomScreenState createState() => _HotelRoomScreenState();
}

class _HotelRoomScreenState extends State<HotelRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BranchDetailsViewModel>.reactive(
        viewModelBuilder: () => BranchDetailsViewModel(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: colorMainBackground,
              appBar: AppBar(
                backgroundColor: colorAppBar,
                elevation: 0.0,
                leading: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Colors.black,
                  ),
                ),
                title: Row(
                  children: const [
                    Text(
                      'Booking App ',
                      textAlign: TextAlign.start,
                      style: homeAppBar,
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(2.h),
                child: FutureBuilder(
                  future: model.allHotelRoomsFromDB(
                      hotelID: widget.hotel.id,
                      userId: widget.selectedUser!.id!),
                  builder: (context, async) {
                    switch (async.connectionState) {
                      case ConnectionState.waiting:
                        return const PleaseWait();
                      case ConnectionState.done:
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            userStatus(widget.selectedUser),
                            const Text('Check For Booking,',
                                style: homeMainHeader),
                            GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: model.hotelRoomsList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 2 / 3,
                              ),
                              itemBuilder: (context, index) => SizedBox(
                                child: RoomsItemsCard(
                                  'assets/images/room.jpg',
                                  hotelRoom: model.hotelRoomsList[index],
                                  userRooms: model.userRoomsList,
                                  booking: () async {
                                    int userID = widget.selectedUser!.id!;
                                    int selectedRoom =
                                        model.hotelRoomsList[index].id!;
                                    await model.updateBookingInDB(context,
                                        hotelID: widget.hotel.id,
                                        userRoom: UserRoom(
                                            idUser: userID,
                                            idRoom: selectedRoom));
                                  },
                                  cancelReservation: () async {
                                    int userID = widget.selectedUser!.id!;
                                    int selectedRoom =
                                        model.hotelRoomsList[index].id!;
                                    await model.cancelBookingInDB(
                                        hotelID: widget.hotel.id,
                                        userRoom: UserRoom(
                                            idUser: userID,
                                            idRoom: selectedRoom));
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      default:
                        return Container(color: Colors.red);
                    }
                  },
                ),
              ),
            ));
  }
}

Widget userStatus(UserData? userData) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      userData != null ? 'Current User: ${userData.name}' : 'No Users Selected',
    ),
    padding: const EdgeInsets.all(7.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: Colors.black),
      color: colorAppMain,
    ),
  );
}
