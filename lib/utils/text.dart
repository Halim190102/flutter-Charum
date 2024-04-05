import 'package:flutter/material.dart';

textUtils({
  required String text,
  Color? color,
  double? size,
  FontWeight? weight,
  TextAlign? align,
  double? letterSpacing,
  TextOverflow? textOverflow,
  int? line,
}) {
  return Text(
    text,
    textAlign: align,
    overflow: textOverflow,
    maxLines: line,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight,
      letterSpacing: letterSpacing,
    ),
  );
}
