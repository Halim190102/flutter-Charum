import 'package:charum/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends ConsumerStatefulWidget {
  const Landing({super.key});

  @override
  ConsumerState<Landing> createState() => _LandingState();
}

class _LandingState extends ConsumerState<Landing> {
  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time') ?? true;

    if (firstTime) {
      await prefs.setBool('first_time', false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/welcome');
      });
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? prefTokens = prefs.getString('tokensKey');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (prefTokens != null) {
          print(prefTokens);
          Navigator.of(context).pushReplacementNamed('/menu');
        } else {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            color: greenCharum,
          ),
        ),
      ),
    );
  }
}
