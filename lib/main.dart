import 'package:booking_assessment/ui/views/home/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'app/locator.dart';

void main() {
  setupLocator();
  runApp(const BookingApp());
}

class BookingApp extends StatelessWidget {
  const BookingApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Booking',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BookingHomeScreen(),
      ),
    );
  }
}
