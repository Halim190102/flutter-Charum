import 'package:charum/views/auth/login.dart';
import 'package:charum/views/auth/signin.dart';
import 'package:charum/views/auth/welcome.dart';
import 'package:charum/views/pages/contains/full_contains.dart';
import 'package:charum/views/pages/landing.dart';
import 'package:charum/views/pages/menu/home/notification.dart';
import 'package:charum/views/pages/menu.dart';
import 'package:charum/views/pages/menu/home/search.dart';
import 'package:charum/views/pages/menu/space/space_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/menu': (_) => const Menu(),
          '/welcome': (_) => const Welcome(),
          '/login': (_) => const Login(),
          '/signin': (_) => const Signin(),
          '/notification': (_) => const Notifications(),
          '/searching': (_) => const Searching(),
          '/spaceoption': (_) => const SpaceOptionItem(),
          '/full': (_) => const FullContains(),
        },
        home: const Landing(),
      ),
    );
  }
}
