import 'package:charum/utils/colors.dart';
import 'package:charum/utils/const.dart';
import 'package:charum/utils/container.dart';
import 'package:charum/utils/text.dart';
import 'package:flutter/material.dart';

tab({
  required int activeTab,
  required List<Widget> widget,
  required MainAxisAlignment main,
  CrossAxisAlignment? cross,
  double? height,
  Widget? widgetList,
  required Widget content,
}) {
  return Column(mainAxisSize: MainAxisSize.min, children: [
    containerUtils(
      height: height,
      color: white,
      padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: cross ?? CrossAxisAlignment.start,
        children: [
          widgetList ?? const SizedBox(),
          Container(
            margin: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: main,
              children: widget,
            ),
          ),
        ],
      ),
    ),
    content
  ]);
}

tabList(int initialTab, int activeTab, IconData icon1, IconData icon2,
    String text, PageController pageController) {
  return GestureDetector(
    onTap: () {
      pageController.jumpToPage(
        activeTab,
      );
    },
    child: containerUtils(
      duration: Duration(milliseconds: time),
      curve: Curves.easeOutSine,
      borderRadius: 8,
      color: initialTab == activeTab ? lightGreen : null,
      width: 105,
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
