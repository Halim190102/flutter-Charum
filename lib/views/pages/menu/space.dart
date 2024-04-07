import 'package:charum/models/topics.dart';
import 'package:charum/utils/colors.dart';
import 'package:charum/utils/const.dart';
import 'package:charum/utils/container.dart';
import 'package:charum/utils/text.dart';
import 'package:charum/utils/text_field_input.dart';
import 'package:charum/view_model/space_view_model.dart';
import 'package:charum/views/pages/menu/space/sorting_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Space extends ConsumerStatefulWidget {
  const Space({super.key});
  @override
  ConsumerState<Space> createState() => _SpaceState();
}

class _SpaceState extends ConsumerState<Space> {
  late TextEditingController _search;

  @override
  void dispose() {
    super.dispose();
    _search.dispose();
  }

  @override
  void initState() {
    super.initState();
    _search = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final option = ref.watch(sortOption);
    final topicItems = ref.watch(spaceProvider);

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
        bottom: _bottomSearchSort(option, context),
      ),
      body: _body(bucket, topicItems),
    );
  }

  _body(PageStorageBucket bucket, List<Topics> topicItems) {
    return PageStorage(
      bucket: bucket,
      key: const PageStorageKey<String>('space'),
      child: GridView.builder(
        itemCount: topicItems.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final spaceOfTopic = topicItems[index];
          return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/spaceoption',
                  arguments: spaceOfTopic,
                );
              },
              child: _listOfGridView(spaceOfTopic));
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2 / 3,
        ),
      ),
    );
  }

  _bottomSearchSort(String option, BuildContext context) {
    return PreferredSize(
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
    );
  }

  _listOfGridView(Topics spaceOfTopic) {
    return containerUtils(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  color: lightGrey,
                  borderRadius: 10,
                  child: textUtils(
                    text: kelipatan3(spaceOfTopic.jumlah!),
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
