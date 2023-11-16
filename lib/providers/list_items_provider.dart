import 'package:riverpod/riverpod.dart';

final listItemsProvider = StateProvider<List<String>>((ref) {
  return [];
});
