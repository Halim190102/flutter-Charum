import 'package:charum/models/topics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final spaceProvider = NotifierProvider<SpacesProvider, List<Topics>>(() {
  return SpacesProvider();
});

class SpacesProvider extends Notifier<List<Topics>> {
  @override
  List<Topics> build() {
    return spaces;
  }

  sortAscending() {
    var s = [...state];
    s.sort((a, b) => a.topics!.compareTo(b.topics!));
    state = s;
  }

  sortDescending() {
    var s = [...state];
    s.sort((a, b) => b.topics!.compareTo(a.topics!));
    state = s;
  }
}
