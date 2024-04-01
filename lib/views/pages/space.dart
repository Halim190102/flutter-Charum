import 'package:charum/utils/colors.dart';
import 'package:charum/utils/container.dart';
import 'package:charum/utils/text.dart';
import 'package:charum/utils/text_field_input.dart';
import 'package:charum/view_model/space_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final spaceBucket = StateProvider((ref) => PageStorageBucket());

class Space extends ConsumerStatefulWidget {
  const Space({super.key});
  @override
  ConsumerState<Space> createState() => _SpaceState();
}

class _SpaceState extends ConsumerState<Space> {
  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _search.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(spaceProvider.notifier).sortMostThreads();
    });
  }

  @override
  Widget build(BuildContext context) {
    final option = ref.watch(sortOption);

    final PageStorageBucket bucket = ref.watch(spaceBucket);
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        surfaceTintColor: white,
        automaticallyImplyLeading: false,
        title: textUtils(
          text: 'Space',
          color: greenCharum,
          weight: FontWeight.w700,
          size: 22,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 35,
                  width: 300,
                  child: TextFieldInput(
                    function: (data) {
                      ref.read(spaceProvider.notifier).search(data, option);
                    },
                    radius: true,
                    textEditingController: _search,
                    isPass: false,
                    hintText: 'Search space',
                    textInputType: TextInputType.text,
                    delete: () {
                      _search.clear();
                      ref.read(spaceProvider.notifier).search('', option);
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _sorting(context);
                  },
                  child: const Icon(Icons.sort),
                ),
              ],
            ),
          ),
        ),
      ),
      body: PageStorage(
        bucket: bucket,
        key: const PageStorageKey<String>('space'),
        child: Consumer(builder: (context, ref, child) {
          final topicItems = ref.watch(spaceProvider);
          return GridView.builder(
            itemCount: topicItems.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              final spaceOfTopic = topicItems[index];
              return containerUtils(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                color: white,
                borderRadius: 10,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/topics/${spaceOfTopic.image!}.png',
                      height: 100,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      height: 95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textUtils(
                                text: spaceOfTopic.topics!,
                                weight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              textUtils(
                                text: spaceOfTopic.explain!,
                                letterSpacing: -0.5,
                                weight: FontWeight.bold,
                                size: 12,
                                color: Colors.black45,
                                textOverflow: TextOverflow.ellipsis,
                                line: 2,
                              ),
                            ],
                          ),
                          containerUtils(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            color: lightGrey,
                            borderRadius: 10,
                            child: textUtils(
                              text: tambahkanTitik(spaceOfTopic.jumlah!),
                              color: grey,
                              size: 12,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2 / 3,
            ),
          );
        }),
      ),
    );
  }

  _sorting(BuildContext context) {
    return showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: white,
      context: context,
      builder: (BuildContext context) {
        return const SortingBottomSheet();
      },
    );
  }
}

class SortingBottomSheet extends ConsumerStatefulWidget {
  const SortingBottomSheet({super.key});

  @override
  ConsumerState<SortingBottomSheet> createState() => _SortingBottomSheetState();
}

class _SortingBottomSheetState extends ConsumerState<SortingBottomSheet> {
  String choose = '';

  @override
  Widget build(BuildContext context) {
    final option = ref.watch(sortOption);
    final confirm = ref.watch(sortConfirm);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        if (confirm == false) {
          if (choose != '') {
            ref.read(sortOption.notifier).state = choose;
            Navigator.pop(context, true);
          } else {
            Navigator.pop(context, true);
          }
        }
      },
      child: containerUtils(
        padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            textUtils(text: "Sort By", weight: FontWeight.bold, size: 16),
            const SizedBox(
              height: 28,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _sortList('A - Z', ref),
                  _sortList('Z - A', ref),
                  // _sortList('Last Updated',ref),
                  _sortList('Most Threads', ref),
                  _sortList('Least Threads', ref),
                ],
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            GestureDetector(
              onTap: () {
                ref.read(sortConfirm.notifier).state = true;
                switch (option) {
                  case 'A - Z':
                    ref.read(spaceProvider.notifier).sortAscending();
                    break;
                  case 'Z - A':
                    ref.read(spaceProvider.notifier).sortDescending();
                    break;
                  case 'Most Threads':
                    ref.read(spaceProvider.notifier).sortMostThreads();
                    break;
                  case 'Least Threads':
                    ref.read(spaceProvider.notifier).sortLeastThreads();
                    break;
                  default:
                }
                Future.delayed(Duration.zero, () {
                  ref.read(sortConfirm.notifier).state = false;

                  Navigator.pop(context);
                });
              },
              child: containerUtils(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                borderRadius: 10,
                color: greenCharum,
                child: textUtils(
                  text: 'Confirm',
                  color: white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _sortList(String title, WidgetRef ref) {
    final option = ref.watch(sortOption);

    return InkWell(
      onTap: () {
        setState(() {
          choose = option;
        });
        ref.read(sortOption.notifier).state = title;
      },
      child: containerUtils(
        borderColor: option == title ? blue : grey,
        borderRadius: 10,
        color: white,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: textUtils(
          text: title,
          color: option == title ? blue : grey,
          weight: option == title ? FontWeight.bold : null,
          size: 12,
        ),
      ),
    );
  }
}
