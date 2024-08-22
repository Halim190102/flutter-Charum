import 'dart:async';

import 'package:charum/utils/colors.dart';
import 'package:charum/views/pages/contains/contains.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetComponentPageStorage extends ConsumerStatefulWidget {
  const WidgetComponentPageStorage({
    super.key,
    required this.bucket,
    required this.keys,
  });
  final PageStorageBucket bucket;
  final String keys;

  @override
  ConsumerState<WidgetComponentPageStorage> createState() =>
      _WidgetComponentPageStorageState();
}

class _WidgetComponentPageStorageState
    extends ConsumerState<WidgetComponentPageStorage> {
  final controller = ScrollController();

  delay(dynamic function) {
    setState(() {
      loading = true;
    });
    Future.delayed(const Duration(seconds: 10), () {
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
        if (count <= 80) {
          delay(count += 4);
        } else {
          delay(null);
        }
      }
    });
  }

  bool loading = false;
  int count = 4;
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
