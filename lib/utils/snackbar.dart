import 'package:charum/utils/colors.dart';
import 'package:charum/utils/text.dart';
import 'package:flutter/material.dart';

showSnackBarFun(context) {
  SnackBar snackBar = SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    content: textUtils(text: 'Yay! A SnackBar at the top!', size: 20),
    backgroundColor: greenCharum,
    dismissDirection: DismissDirection.up,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 180, left: 10, right: 10),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
