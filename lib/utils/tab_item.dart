import 'package:charum/utils/colors.dart';
import 'package:charum/utils/const.dart';
import 'package:charum/utils/container.dart';
import 'package:charum/utils/text.dart';
import 'package:flutter/material.dart';

tab(
  int activeTab,
  List<Widget> widget,
  MainAxisAlignment main,
  double height,
  Widget? widgetList,
  Widget? content,
) {
  return Column(children: [
    containerUtils(
      height: height,
      color: white,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          widgetList!,
          Row(
            mainAxisAlignment: main,
            children: widget,
          ),
        ],
      ),
    ),
    content!
  ]);
}

tabList(int initialTab, int activeTab, IconData icon1, IconData icon2,
    String text, PageController pageController) {
  return GestureDetector(
    onTap: () {
      pageController.animateToPage(
        activeTab,
        duration: Duration(milliseconds: time),
        curve: Curves.ease,
      );
    },
    child: containerUtils(
      duration: Duration(milliseconds: time),
      curve: Curves.easeOutSine,
      borderRadius: 8,
      color: initialTab == activeTab ? lightGreen : null,
      width: 110,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            initialTab == activeTab ? icon1 : icon2,
            color: initialTab == activeTab ? greenCharum : null,
          ),
          textUtils(
            text: text,
            color: initialTab == activeTab ? greenCharum : null,
          )
        ],
      ),
    ),
  );
}
