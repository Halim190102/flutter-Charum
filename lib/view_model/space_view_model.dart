import 'package:charum/models/topics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final spaceProvider =
    StateNotifierProvider<SpacesProvider, List<Topics>>((ref) {
  return SpacesProvider();
});

class SpacesProvider extends StateNotifier<List<Topics>> {
  SpacesProvider() : super(spaces);

  sortAscending() {
    state.sort((a, b) => a.topics!.compareTo(b.topics!));
  }

  sortDescending() {
    state.sort((a, b) => b.topics!.compareTo(a.topics!));
  }
}
