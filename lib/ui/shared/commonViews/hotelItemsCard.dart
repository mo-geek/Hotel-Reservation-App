import 'package:booking_assessment/ui/shared/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HotelItemsCard extends StatelessWidget {
  final Function function;
  final String text;
  final String image;
  const HotelItemsCard(this.image,
      {Key? key, required this.text, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigate to rooms screen
        function();
      },
      child: Column(
        children: [
          Container(
            height: 30.w,
            width: 30.w,
            margin: const EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(27),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
              child: Text(
            text,
            style: hotelTextStyle,
            textAlign: TextAlign.center,
            softWrap: true,
          )),
        ],
      ),
    );
  }
}
