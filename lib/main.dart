// import 'package:charum/views/pages/menu.dart';
import 'package:charum/views/auth/login.dart';
import 'package:charum/views/auth/signin.dart';
import 'package:charum/views/auth/welcome.dart';
import 'package:charum/views/pages/menu/home/notification.dart';
import 'package:charum/views/pages/menu.dart';
import 'package:charum/views/pages/menu/home/search.dart';
import 'package:charum/views/pages/menu/space/space_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (_) => const Menu(),
          '/welcome': (_) => Welcome(size: size),
          '/login': (_) => const Login(),
          '/signin': (_) => const Signin(),
          '/notification': (_) => const Notifications(),
          '/searching': (_) => const Searching(),
          '/spaceoption': (_) => const SpaceOptionItem(),
        },
        initialRoute: '/welcome',
        // home: Welcome(
        //   size: size,
        // ),
        // // home: Menu(),
      ),
    );
  }
}
