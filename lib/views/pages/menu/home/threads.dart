import 'dart:async';

import 'package:charum/utils/colors.dart';
import 'package:charum/view_model/home_view_model.dart';
import 'package:charum/views/pages/contains/contains.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Threads extends ConsumerStatefulWidget {
  const Threads({super.key});

  @override
  ConsumerState<Threads> createState() => _ThreadsState();
}

class _ThreadsState extends ConsumerState<Threads> {
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
    final PageStorageBucket bucket = ref.watch(threadsBucket);

    return PageStorage(
      bucket: bucket,
      key: const PageStorageKey<String>('threads'),
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
