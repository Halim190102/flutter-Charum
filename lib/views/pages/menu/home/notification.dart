import 'package:charum/utils/colors.dart';
import 'package:charum/utils/text.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textUtils(
          text: 'Notification',
          weight: FontWeight.w600,
        ),
      ),
      backgroundColor: lightGrey,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo/bell.png',
                width: 180,
              ),
              const SizedBox(
                height: 5,
              ),
              textUtils(
                text: 'You do not haven\nany notification right now.',
                align: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
