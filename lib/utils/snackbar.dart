import 'package:charum/utils/colors.dart';
import 'package:charum/utils/text.dart';
import 'package:flutter/material.dart';

showSnackBarFun(context) {
  SnackBar snackBar = SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: white,
          child: Icon(
            Icons.done_rounded,
            color: greenCharum,
            size: 16,
          ),
        ),
        textUtils(
          text: '  Thread added to your Bookmarks',
          size: 12,
        )
      ],
    ),
    backgroundColor: greenCharum,
    dismissDirection: DismissDirection.up,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 150, left: 10, right: 10),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  Navigator.pop(context);
}
