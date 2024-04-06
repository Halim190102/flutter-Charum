import 'package:charum/models/topics.dart';
import 'package:charum/utils/colors.dart';
import 'package:charum/utils/tab_item.dart';
import 'package:charum/utils/text.dart';
import 'package:charum/view_model/space_view_model.dart';
import 'package:charum/views/pages/contains/content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpaceOptionItem extends ConsumerStatefulWidget {
  const SpaceOptionItem({super.key});

  @override
  ConsumerState<SpaceOptionItem> createState() => _SpaceOptionItemState();
}

class _SpaceOptionItemState extends ConsumerState<SpaceOptionItem> {
  late PageController _pageController;

  int tabInitial = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _pageController = PageController(initialPage: tabInitial);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topics = ModalRoute.of(context)!.settings.arguments as Topics;
    final threads = ref.watch(sthreadsBucket);
    final popular = ref.watch(spopularBucket);

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          ref.invalidate(sthreadsBucket);
          ref.invalidate(spopularBucket);
        }
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          toolbarHeight: 30,
          actions: [
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
          ],
        ),
        body: tab(
          tabInitial,
          _listTab(),
          MainAxisAlignment.start,
          170,
          _leadingText(topics),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: _pageViewChange,
              children: [
                Content(bucket: threads, keys: 'sthreads'),
                Content(bucket: popular, keys: 'spopular'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _listTab() {
    return [
      tabList(
        tabInitial,
        0,
        Icons.article,
        Icons.article_outlined,
        ' Threads',
        _pageController,
      ),
      tabList(
        tabInitial,
        1,
        Icons.star_outlined,
        Icons.star_border,
        ' Popular',
        _pageController,
      ),
    ];
  }

  _leadingText(Topics topics) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textUtils(
          text: topics.topics!,
          weight: FontWeight.bold,
          size: 16,
        ),
        const SizedBox(
          height: 6,
        ),
        textUtils(
          text: topics.explain!,
          size: 12,
          align: TextAlign.justify,
        ),
      ],
    );
  }

  _pageViewChange(index) {
    setState(() {
      tabInitial = index;
    });
  }
}
