import 'package:charum/utils/colors.dart';
import 'package:charum/utils/text.dart';
import 'package:flutter/material.dart';

modal(context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (ctx) => AlertDialog(
      contentPadding: const EdgeInsets.only(bottom: 20),
      backgroundColor: white,
      surfaceTintColor: transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.antiAlias,
      title: Image.asset(
        'assets/logo/loading.png',
        width: 120,
      ),
      content: textUtils(
        text: "Please wait...",
        weight: FontWeight.bold,
        size: 18,
        align: TextAlign.center,
      ),
    ),
  );
}
