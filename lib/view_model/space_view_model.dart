import 'package:charum/models/topics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final spaceProvider =
    StateNotifierProvider<SpacesProvider, List<Topics>>((ref) {
  return SpacesProvider();
});

final sortOption = StateProvider((ref) => 'Most Threads');

final sortConfirm = StateProvider((ref) => false);

class SpacesProvider extends StateNotifier<List<Topics>> {
  SpacesProvider() : super(spaces);

  sortAscending() {
    List<Topics> s = List.from(spaces);
    s.sort((a, b) => a.topics!.compareTo(b.topics!));
    state = s;
  }

  sortDescending() {
    List<Topics> s = List.from(spaces);
    s.sort((a, b) => b.topics!.compareTo(a.topics!));
    state = s;
  }

  sortMostThreads() {
    List<Topics> s = List.from(spaces);
    s.sort((a, b) => b.jumlah!.compareTo(a.jumlah!));
    state = s;
  }

  sortLeastThreads() {
    List<Topics> s = List.from(spaces);
    s.sort((a, b) => a.jumlah!.compareTo(b.jumlah!));
    state = s;
  }

  search(String query, String option) {
    List<Topics> f = List.from(spaces);
    List<Topics> s = [];
    s = f
        .where((e) => e.topics!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    s.sort((a, b) => a.topics!.compareTo(b.topics!));

    if (query == '') {
      switch (option) {
        case 'A - Z':
          sortAscending();
          break;
        case 'Z - A':
          sortDescending();
          break;
        case 'Most Threads':
          sortMostThreads();
          break;
        case 'Least Threads':
          sortLeastThreads();
          break;
        default:
          state = f;
      }
    } else {
      state = s;
    }
  }
}
