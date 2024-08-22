import 'dart:async';

import 'package:charum/utils/colors.dart';
import 'package:charum/utils/const.dart';
import 'package:charum/view_model/account_view_model.dart';
import 'package:charum/view_model/auth_view_model.dart';
import 'package:charum/view_model/bookmark_view_model.dart';
import 'package:charum/view_model/home_view_model.dart';
import 'package:charum/view_model/space_view_model.dart';
import 'package:charum/views/pages/menu/home.dart';
import 'package:charum/views/pages/menu/bookmark.dart';
import 'package:charum/views/pages/menu/account.dart';
import 'package:charum/views/pages/menu/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Menu extends ConsumerStatefulWidget {
  const Menu({super.key});

  @override
  ConsumerState<Menu> createState() => _MenuState();
}

class _MenuState extends ConsumerState<Menu> {
  Timer? timer;
  int _page = 0;

  late PageController pageController;

  void _fetchDataUser() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(authProvider.notifier).getDataUser(context: context);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDataUser();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(spaceProvider.notifier).sortAscending();
    });
    pageController = PageController(initialPage: _page);
  }

  @override
  void dispose() {
    super.dispose();
    cancelRefresh();
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
          children: const <Widget>[
            Home(),
            Space(),
            Bookmark(),
            Account(),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
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

  List<Widget> menu = const [];

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
    pageController.jumpToPage(
      page,
    );
    if (_page != 1) {
      ref.invalidate(searchings);
    }
    cancelRefresh();
    timer = Timer(Duration(hours: refreshTime), () {
      if (_page != 0) {
        functionState(ref);
      }
      if (_page != 1) {
        ref.invalidate(spaceBucket);
      }
      if (_page != 2) {
        ref.invalidate(bookmarkBucket);
      }
      if (_page != 3) {
        ref.invalidate(athreadsBucket);
      }
    });
  }
}
