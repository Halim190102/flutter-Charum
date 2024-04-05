import 'package:charum/utils/colors.dart';
import 'package:charum/utils/text.dart';
import 'package:charum/utils/text_field_input.dart';
import 'package:charum/view_model/bookmark_view_model.dart';
import 'package:charum/views/pages/contains/contains.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Bookmark extends ConsumerStatefulWidget {
  const Bookmark({super.key});
  @override
  ConsumerState<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends ConsumerState<Bookmark> {
  late TextEditingController _search;
  final controller = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _search.dispose();
  }

  delay(dynamic function) {
    setState(() {
      loading = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        function;
        loading = false;
      });
    });
  }

  bool loading = false;
  int count = 2;

  @override
  void initState() {
    super.initState();
    _search = TextEditingController();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        if (count <= 10) {
          delay(count += 2);
        } else {
          delay(null);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final PageStorageBucket bucket = ref.watch(bookmarkBucket);
    return Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          surfaceTintColor: white,
          automaticallyImplyLeading: false,
          title: textUtils(
            text: 'Bookmark',
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
                    width: MediaQuery.of(context).size.width - 30,
                    child: TextFieldInput(
                      function: (data) {},
                      radius: true,
                      textEditingController: _search,
                      isPass: false,
                      hintText: 'Search space',
                      textInputType: TextInputType.text,
                      delete: () {
                        _search.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: PageStorage(
          bucket: bucket,
          key: const PageStorageKey<String>('bookmark'),
          child: ListView.builder(
            controller: controller,
            itemBuilder: (context, index) {
              if (index < count) {
                return const ItemList();
              } else {
                if (loading) {
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: greenCharum,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }
            },
            itemCount: count + 1,
          ),
        ));
  }
}
