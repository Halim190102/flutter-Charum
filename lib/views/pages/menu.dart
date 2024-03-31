import 'dart:async';

import 'package:charum/views/pages/home/followed.dart';
import 'package:charum/views/pages/home/popular.dart';
import 'package:charum/views/pages/home/threads.dart';
import 'package:flutter/material.dart';
import 'package:charum/utils/colors.dart';
import 'package:charum/views/pages/home.dart';
import 'package:charum/views/pages/space.dart';
import 'package:charum/views/pages/home2.dart';
import 'package:charum/views/pages/home3.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Menu extends ConsumerStatefulWidget {
  const Menu({super.key});

  @override
  ConsumerState<Menu> createState() => _MenuState();
}

class _MenuState extends ConsumerState<Menu> {
  Timer? timer;
  int refreshTime = 5;
  int _page = 0;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _page);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
          children: menu,
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: greenCharum,
          unselectedItemColor: grey,
          onTap: onTap,
          backgroundColor: white,
          showUnselectedLabels: true,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          currentIndex: _page,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                _page == 0 ? Icons.home : Icons.home_outlined,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _page == 1 ? Icons.people : Icons.people_outline,
              ),
              label: 'Space',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _page == 2 ? Icons.bookmark : Icons.bookmark_outline,
              ),
              label: 'Bookmark',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _page == 3 ? Icons.person : Icons.person_outline,
              ),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> menu = const [
    Home(),
    Space(),
    Home2(),
    Home3(),
  ];

  cancelRefresh() {
    if (timer != null) {
      timer!.cancel();
    }
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void onTap(page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    cancelRefresh();
    timer = Timer(Duration(seconds: refreshTime), () {
      if (_page != 0) {
        ref.invalidate(tabHomeIndexProvider);
        ref.invalidate(popularBucket);
        ref.invalidate(followedBucket);
        ref.invalidate(threadsBucket);
      }
      if (_page != 1) {
        ref.invalidate(spaceBucket);
      }
      if (_page != 2) {
        ref.invalidate(tabHomeIndexProvider2);
        ref.invalidate(homeBucket2);
      }
      if (_page != 3) {
        ref.invalidate(tabHomeIndexProvider3);
        ref.invalidate(homeBucket3);
      }
    });
  }
}
