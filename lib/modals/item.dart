// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 1)
class ItemsList {
  @HiveField(0)
  List<String> items;
  ItemsList({
    required this.items,
  });
}
