import 'dart:io';

import 'package:booking_assessment/ui/shared/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PleaseWait extends StatelessWidget {
  const PleaseWait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 200),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.714285714),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Platform.isAndroid
                      ? const CircularProgressIndicator(
                          color: colorAppSub,
                        )
                      : const CupertinoActivityIndicator(),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Text(
                    'please wait ... ',
                    style: TextStyle(
                      fontSize: 21.0,
                      color: colorAppSub,
                    ),
                  ),
                ],
              )),
            ),
          )
        ],
      ),
    );
  }
}
