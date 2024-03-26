import 'package:charum/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int aa = 0;
  int activeTab = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController =
        TabController(vsync: this, length: 3, initialIndex: activeTab);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void onTabChanged(int page) {
    setState(() {
      activeTab = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 218, 218),
      appBar: AppBar(
        bottom: TabBar(
          labelColor: greenCharum,
          indicatorColor: greenCharum,
          controller: tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    activeTab == 0 ? Icons.article : Icons.article_outlined,
                    color: activeTab == 0 ? greenCharum : null,
                  ),
                  const Text(" Threads")
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
                  const Text(" Popular")
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
                  const Text(" Followed")
                ],
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: Image.asset('assets/logo/logo-leading.png'),
            ),
            Text(
              ' Charum',
              style: TextStyle(
                color: greenCharum,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.bell,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.search,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
