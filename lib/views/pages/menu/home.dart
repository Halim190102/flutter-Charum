import 'package:charum/utils/colors.dart';
import 'package:charum/utils/tab_item.dart';
import 'package:charum/utils/text.dart';
import 'package:charum/view_model/home_view_model.dart';
import 'package:charum/views/pages/menu/home/followed.dart';
import 'package:charum/views/pages/menu/home/popular.dart';
import 'package:charum/views/pages/menu/home/threads.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late PageController _pageController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int initial = ref.watch(tabHomeIndexProvider);
    _pageController = PageController(initialPage: initial);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeTab = ref.watch(tabHomeIndexProvider);
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        surfaceTintColor: white,
        title: _logo(),
        actions: _trailingButton(context),
      ),
      body: tab(
        activeTab,
        _listTab(activeTab),
        MainAxisAlignment.spaceAround,
        54,
        const SizedBox(),
        _content(),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {},
        child: CircleAvatar(
          radius: 25,
          backgroundColor: greenCharum,
          child: Icon(
            Icons.add,
            color: white,
          ),
        ),
      ),
    );
  }

  _content() {
    return Expanded(
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: _pageViewChange,
        children: pages,
      ),
    );
  }

  List<Widget> _listTab(int activeTab) {
    return [
      tabList(
        activeTab,
        0,
        Icons.article,
        Icons.article_outlined,
        ' Threads',
        _pageController,
      ),
      tabList(
        activeTab,
        1,
        Icons.star_outlined,
        Icons.star_border,
        ' Popular',
        _pageController,
      ),
      tabList(
        activeTab,
        2,
        Icons.add_chart,
        Icons.add_chart_outlined,
        ' Followed',
        _pageController,
      ),
    ];
  }

  void _pageViewChange(index) {
    ref.read(tabHomeIndexProvider.notifier).state = index;
  }

  _logo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: Image.asset('assets/logo/logo-leading.png'),
        ),
        textUtils(
          text: ' Charum',
          color: greenCharum,
          weight: FontWeight.bold,
          size: 18,
        )
      ],
    );
  }

  List<Widget> pages = const [
    Threads(),
    Popular(),
    Followed(),
  ];

  _trailingButton(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/notification',
          );
        },
        icon: Stack(
          alignment: Alignment.topRight,
          children: [
            const Icon(
              CupertinoIcons.bell,
              size: 30,
            ),
            Positioned(
              right: 3,
              child: CircleAvatar(
                radius: 7,
                backgroundColor: red,
                child: textUtils(
                  text: '18',
                  color: white,
                  size: 7,
                ),
              ),
            ),
          ],
        ),
      ),
      IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/searching',
          );
        },
        icon: const Icon(
          CupertinoIcons.search,
          size: 30,
        ),
      ),
    ];
  }
}
