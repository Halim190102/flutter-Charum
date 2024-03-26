import 'package:charum/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabHomeIndexProvider = StateProvider((ref) => 0);
final homeBucket = StateProvider((ref) => PageStorageBucket());

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageStorageBucket bucket = ref.watch(homeBucket);
    print("object");
    final activeTab = ref.watch(tabHomeIndexProvider);
    return DefaultTabController(
      length: 3,
      initialIndex: activeTab,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 218, 218, 218),
        appBar: AppBar(
          bottom: TabBar(
            onTap: (value) {
              ref.read(tabHomeIndexProvider.notifier).state = value;
            },
            labelColor: greenCharum,
            indicatorColor: greenCharum,
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
                      activeTab == 2
                          ? Icons.add_chart
                          : Icons.add_chart_outlined,
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
        body: PageStorage(
          bucket: bucket,
          child: ListView.builder(
            key: PageStorageKey<String>('home'),
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: 40,
                margin: EdgeInsets.all(12),
                color: Colors.green,
              );
            },
            itemCount: 20,
          ),
        ),
      ),
    );
  }
}
