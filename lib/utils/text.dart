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

String tambahkanTitik(int angka) {
  String angkaString = angka.toString();
  String hasil = '';
  int counter = 0;

  for (int i = angkaString.length - 1; i >= 0; i--) {
    hasil = angkaString[i] + hasil;
    counter++;
    if (counter == 3 && i != 0) {
      hasil = '.$hasil';
      counter = 0;
    }
  }
  if (angka <= 1) {
    hasil += ' thread';
  } else {
    hasil += ' threads';
  }
  return hasil;
}
