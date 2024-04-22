import 'package:charum/utils/colors.dart';
import 'package:charum/utils/const.dart';
import 'package:charum/utils/container.dart';
import 'package:charum/utils/tab_item.dart';
import 'package:charum/utils/text.dart';
import 'package:charum/view_model/bookmark_view_model.dart';
import 'package:charum/view_model/home_view_model.dart';
import 'package:charum/view_model/space_view_model.dart';
import 'package:charum/views/pages/contains/widget_component_page_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final athreadsBucket = StateProvider((ref) => PageStorageBucket());

class Account extends ConsumerStatefulWidget {
  const Account({super.key});
  @override
  ConsumerState<Account> createState() => _AccountState();
}

class _AccountState extends ConsumerState<Account> {
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
    final threads = ref.watch(athreadsBucket);

    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: textUtils(
          text: 'Account',
          color: greenCharum,
          weight: FontWeight.w700,
          size: 22,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false).then((value) {
                ref.invalidate(tabHomeIndexProvider);
                ref.invalidate(hpopularBucket);
                ref.invalidate(hfollowedBucket);
                ref.invalidate(hthreadsBucket);
                ref.invalidate(spaceBucket);
                ref.invalidate(bookmarkBucket);
                ref.invalidate(athreadsBucket);
              });
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: tab(
        activeTab: tabInitial,
        widget: _listTab(),
        cross: CrossAxisAlignment.center,
        main: MainAxisAlignment.start,
        widgetList: _leadingText(),
        content: Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: _pageViewChange,
            children: [
              WidgetComponentPageStorage(bucket: threads, keys: 'athreads'),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: containerUtils(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textUtils(
                            text:
                                'Hello, my name is Muhammad Sumbul. Lorem ipsum dolor sit amet consectetur. Sagittis faucibus malesuada vitae sodales tortor at. Turpis ullamcorper quam imperdiet risus aliquam eu. Accumsan risus fames diam non quam augue dictum. Lorem ipsum dolor sit amet consectetur. Sagittis faucibus malesuada vitae sodales tortor at.',
                            size: 12,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          textUtils(
                            text:
                                "Contact me in :\ninstagram : @muhsumbul\ntwitter : supersumbul\nemail : muhsumbul123@gmail.com",
                            size: 12,
                          ),
                        ],
                      ),
                      color: white,
                      padding: const EdgeInsets.all(15),
                      borderRadius: 8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _textNumber(String number, String title) {
    return SizedBox(
      width: 60,
      child: Column(
        children: [
          textUtils(
            text: number,
            weight: FontWeight.bold,
            size: 12,
          ),
          textUtils(text: title, size: 12, color: grey),
        ],
      ),
    );
  }

  _leadingText() {
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          child: Image.asset(
            'assets/logo/avatar.png',
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        textUtils(
          text: 'Ade Winda',
          weight: FontWeight.bold,
        ),
        textUtils(
          text: 'adewinda00',
          size: 12,
          color: grey,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _textNumber(kelipatan3(12, false), 'Thread'),
            _textNumber(kelipatan3(2741, false), 'Followers'),
            _textNumber(kelipatan3(1078, false), 'Following')
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            containerUtils(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
              borderRadius: 6,
              color: greenCharum,
              child: textUtils(text: 'Edit Profile', color: white, size: 12),
            ),
            const SizedBox(
              width: 6,
            ),
            containerUtils(
              borderRadius: 6,
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              color: lightGrey,
              child: Icon(
                Icons.mail_outline_rounded,
                size: 14,
                color: grey,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
      ],
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
        Icons.info,
        Icons.info_outline,
        ' Popular',
        _pageController,
      ),
    ];
  }

  _pageViewChange(index) {
    setState(() {
      tabInitial = index;
    });
  }
}
