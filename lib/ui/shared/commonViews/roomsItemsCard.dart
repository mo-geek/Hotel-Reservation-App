import 'package:booking_assessment/core/models/hotelRoom.dart';
import 'package:booking_assessment/core/models/userRoom.dart';
import 'package:booking_assessment/ui/shared/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RoomsItemsCard extends StatelessWidget {
  const RoomsItemsCard(
    this.image, {
    Key? key,
    required this.hotelRoom,
    this.booking,
    required this.userRooms,
    this.cancelReservation,
  }) : super(key: key);
  final String image;
  final HotelRoom hotelRoom;
  final List<HotelRoom> userRooms;
  final Function? booking;
  final Function? cancelReservation;
  String checkRoomType(RoomType rm) {
    switch (rm) {
      case RoomType.single:
        return 'single';
      case RoomType.double:
        return 'double';
      case RoomType.suite:
        return 'suite';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('booking now!');
        // booking the room if not reserved ...
        if (booking != null) booking!();
      },
      child: Column(
        children: [
          Container(
            height: 30.w,
            width: 30.w,
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(27),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.topRight,
            child: Visibility(
              visible: userRooms.contains(hotelRoom),
              child: GestureDetector(
                onTap: () {
                  if (cancelReservation != null) cancelReservation!();
                },
                child: const Icon(Icons.cancel),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                hotelRoom.isBooked ? 'Reserved' : 'Book NOW',
                style: hotelRoom.isBooked ? bookedTextStyle : hotelTextStyle,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
              Text(
                checkRoomType(hotelRoom.type),
                style: hotelTextStyle,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
              Text(
                '${hotelRoom.price} EGP',
                style: hotelTextStyle,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
