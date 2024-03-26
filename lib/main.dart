import 'package:charum/views/auth/welcome.dart';
import 'package:charum/views/pages/menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Welcome(
        //   size: size,
        // ),
        home: Menu(),
      ),
    );
  }
}