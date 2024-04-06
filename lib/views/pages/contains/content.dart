import 'dart:async';

import 'package:charum/utils/colors.dart';
import 'package:charum/views/pages/contains/contains.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Content extends ConsumerStatefulWidget {
  const Content({
    super.key,
    required this.bucket,
    required this.keys,
  });
  final PageStorageBucket bucket;
  final String keys;

  @override
  ConsumerState<Content> createState() => _ContentState();
}

class _ContentState extends ConsumerState<Content> {
  final controller = ScrollController();

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

  @override
  void initState() {
    super.initState();
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

  bool loading = false;
  int count = 2;
  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: widget.bucket,
      key: PageStorageKey(widget.keys),
      child: _listView(),
    );
  }

  ListView _listView() {
    return ListView.builder(
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
    );
  }
}
