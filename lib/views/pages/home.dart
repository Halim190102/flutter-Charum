import 'package:charum/utils/colors.dart';
import 'package:charum/utils/text.dart';
import 'package:charum/views/pages/home/followed.dart';
import 'package:charum/views/pages/home/popular.dart';
import 'package:charum/views/pages/home/threads.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabHomeIndexProvider = StateProvider((ref) => 0);

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int initial = ref.watch(tabHomeIndexProvider);
    _pageController = PageController(initialPage: initial);
    _tabController =
        TabController(length: pages.length, vsync: this, initialIndex: initial);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        bottom: _tabBar(activeTab),
        title: _logo(),
        actions: _trailingButton(context),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: _pageViewChange,
        children: pages,
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

  _tabBar(int activeTab) {
    return TabBar(
      controller: _tabController,
      onTap: _onTapTabBar,
      labelColor: greenCharum,
      indicatorColor: greenCharum,
      tabs: _tabMethod(activeTab),
    );
  }

  _pageViewChange(index) {
    ref.read(tabHomeIndexProvider.notifier).state = index;
    _tabController.animateTo(index);
  }

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
        onPressed: () {},
        icon: const Icon(
          CupertinoIcons.search,
          size: 30,
        ),
      ),
    ];
  }

  _onTapTabBar(value) {
    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  _tabMethod(int activeTab) {
    return [
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              activeTab == 0 ? Icons.article : Icons.article_outlined,
              color: activeTab == 0 ? greenCharum : null,
            ),
            textUtils(text: " Threads")
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              activeTab == 1 ? Icons.star_outlined : Icons.star_border,
              color: activeTab == 1 ? greenCharum : null,
            ),
            textUtils(text: " Popular")
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              activeTab == 2 ? Icons.add_chart : Icons.add_chart_outlined,
              color: activeTab == 2 ? greenCharum : null,
            ),
            textUtils(text: " Followed")
          ],
        ),
      ),
    ];
  }
}
