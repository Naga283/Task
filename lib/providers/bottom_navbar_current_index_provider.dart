import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentIndexStateProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});
