import 'package:charum/utils/colors.dart';
import 'package:flutter/material.dart';

showSnackBarFun(context, Widget widget) {
  SnackBar snackBar = SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    content: widget,
    backgroundColor: greenCharum,
    dismissDirection: DismissDirection.startToEnd,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 150, left: 10, right: 10),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
