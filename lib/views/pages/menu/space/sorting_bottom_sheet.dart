import 'package:charum/utils/colors.dart';
import 'package:charum/utils/container.dart';
import 'package:charum/utils/text.dart';
import 'package:charum/view_model/space_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SortingBottomSheet extends ConsumerStatefulWidget {
  const SortingBottomSheet({super.key});

  @override
  ConsumerState<SortingBottomSheet> createState() => _SortingBottomSheetState();
}

class _SortingBottomSheetState extends ConsumerState<SortingBottomSheet> {
  List choose = [];

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
          if (choose.isNotEmpty) {
            ref.read(sortOption.notifier).state = choose[0];
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
            _listOfSort(),
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

  Align _listOfSort() {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _sortList('A - Z', ref),
          _sortList('Z - A', ref),
          _sortList('Most Threads', ref),
          _sortList('Least Threads', ref),
        ],
      ),
    );
  }

  _sortList(String title, WidgetRef ref) {
    final option = ref.watch(sortOption);

    return InkWell(
      onTap: () {
        setState(() {
          choose.add(option);
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
