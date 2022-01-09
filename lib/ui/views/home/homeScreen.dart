import 'package:booking_assessment/core/viewmodels/hotelBranchesViewModel.dart';
import 'package:booking_assessment/ui/shared/commonViews/hotelItemsCard.dart';
import 'package:booking_assessment/ui/shared/commonWidgets/toastShow.dart';
import 'package:booking_assessment/ui/shared/commonWidgets/waitplease.dart';
import 'package:booking_assessment/ui/shared/style/colors.dart';
import 'package:booking_assessment/ui/shared/style/text_style.dart';
import 'package:booking_assessment/ui/views/branchInfo/rooms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';

class BookingHomeScreen extends StatefulWidget {
  const BookingHomeScreen({Key? key}) : super(key: key);

  @override
  _BookingHomeScreenState createState() => _BookingHomeScreenState();
}

class _BookingHomeScreenState extends State<BookingHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HotelBranchesViewModel>.reactive(
      viewModelBuilder: () => HotelBranchesViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: colorMainBackground,
        appBar: AppBar(
          backgroundColor: colorAppBar,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
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
            future: model.fetchHomeScreenData(),
            builder: (context, async) {
              switch (async.connectionState) {
                case ConnectionState.waiting:
                  return const PleaseWait();
                case ConnectionState.done:
                  return model.hotelList.isEmpty
                      ? Center(
                          child: MaterialButton(
                            onPressed: () async {
                              await model.generateDefaultData();
                            },
                            child: const Text(
                              'DEFAULT DATA',
                              style: TextStyle(color: Colors.amber),
                            ),
                            color: colorAppBar,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Enjoy Your Next Stay,',
                                    style: homeMainHeader),
                                selectUserDropButton(model),
                              ],
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: model.hotelList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 2 / 3,
                              ),
                              itemBuilder: (context, index) => SizedBox(
                                child: HotelItemsCard(
                                  'assets/images/hotel.jpg',
                                  text: model.hotelList[index].name,
                                  function: () {
                                    if (model.selectedUser == null) {
                                      FToast fToast = FToast();
                                      fToast.init(context);
                                      ShowMessage.showToast(
                                          'please select user to booking your desired room');
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HotelRoomScreen(
                                            hotel: model.hotelList[index],
                                            selectedUser: model.selectedUser,
                                          ),
                                        ),
                                      );
                                    }
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
      ),
    );
  }
}

Widget selectUserDropButton(HotelBranchesViewModel model) {
  return DropdownButton<dynamic>(
    items: [
      for (var user in model.userList)
        DropdownMenuItem(
          child: Text(user.name),
          value: user.id,
        )
    ],
    onChanged: (val) {
      print(val);
      model.selectUser(val);
    },
    value: model.selectedUserId,
    hint: Container(
      child: const Text(
        'Select User',
      ),
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.black),
        color: colorAppMain,
      ),
    ),
  );
}
