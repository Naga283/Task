import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task/constants/hive_box_name.dart';
import 'package:task/utils/colors.dart';
import 'package:task/utils/styles.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final TextEditingController addItemController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final box = Hive.box(hiveBoxNames.commonBox);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ValueListenableBuilder<Box>(
          valueListenable: Hive.box(hiveBoxNames.commonBox).listenable(),
          builder: (context, box, widget) {
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      boxShadow: appStyles.boxShadow,
                      color: appColors.whiteColor,
                    ),
                    child: ListTile(
                      title: Text(box.getAt(index)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              addItemController.text = box.getAt(index);
                              await dailogFunc(
                                context,
                                box,
                                () {
                                  box.putAt(index, "${addItemController.text}");
                                  // ref.read(listItemsProvider).add(addItemController.text);
                                  addItemController.clear();
                                  Navigator.pop(context);
                                },
                                "Update",
                                "Update Item",
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              box.deleteAt(index);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await dailogFunc(
            context,
            box,
            () {
              box.add("${addItemController.text}");
              // ref.read(listItemsProvider).add(addItemController.text);
              addItemController.clear();
              Navigator.pop(context);
            },
            "Add",
            "Add Item",
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> dailogFunc(
    BuildContext context,
    Box<dynamic> box,
    Function()? onTap,
    String btnName,
    String heading,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(heading),
          content: TextFormField(
            controller: addItemController,
          ),
          actions: [
            TextButton(
              onPressed: onTap,
              child: Text(btnName),
            )
          ],
        );
      },
    );
  }
}
