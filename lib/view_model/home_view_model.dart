import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabHomeIndexProvider = StateProvider((ref) => 0);

final followedBucket = StateProvider((ref) => PageStorageBucket());

final popularBucket = StateProvider((ref) => PageStorageBucket());

final threadsBucket = StateProvider((ref) => PageStorageBucket());
