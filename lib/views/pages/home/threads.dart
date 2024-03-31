import 'dart:async';

import 'package:charum/utils/colors.dart';
import 'package:charum/views/pages/contains/contains.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final threadsBucket = StateProvider((ref) => PageStorageBucket());

class Threads extends ConsumerStatefulWidget {
  const Threads({super.key});

  @override
  ConsumerState<Threads> createState() => _ThreadsState();
}

class _ThreadsState extends ConsumerState<Threads> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        if (count <= 10) {
          setState(() {
            loading = true;
          });
          Timer(const Duration(seconds: 1), () {
            setState(() {
              count += 2;
              loading = false;
            });
          });
        } else {
          setState(() {
            loading = true;
          });
          Timer(const Duration(seconds: 1), () {
            setState(() {
              loading = false;
            });
          });
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
