import 'dart:async';

import 'package:charum/utils/colors.dart';
import 'package:charum/view_model/home_view_model.dart';
import 'package:charum/views/pages/contains/contains.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Popular extends ConsumerStatefulWidget {
  const Popular({super.key});

  @override
  ConsumerState<Popular> createState() => _PopularState();
}

class _PopularState extends ConsumerState<Popular> {
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
    final PageStorageBucket bucket = ref.watch(popularBucket);

    return PageStorage(
      bucket: bucket,
      key: const PageStorageKey<String>('popular'),
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
    );
  }
}
