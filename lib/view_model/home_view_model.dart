import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabHomeIndexProvider = StateProvider((ref) => 0);

final hfollowedBucket = StateProvider((ref) => PageStorageBucket());

final hpopularBucket = StateProvider((ref) => PageStorageBucket());

final hthreadsBucket = StateProvider((ref) => PageStorageBucket());

functionState(WidgetRef ref) {
  ref.invalidate(tabHomeIndexProvider);
  ref.invalidate(hpopularBucket);
  ref.invalidate(hfollowedBucket);
  ref.invalidate(hthreadsBucket);
}
