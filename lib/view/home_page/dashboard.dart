import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
    final currentUserDetails = FirebaseAuth.instance.currentUser?.uid ?? '';
    final box = Hive.box(currentUserDetails);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: appColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ValueListenableBuilder<Box>(
          valueListenable: Hive.box(currentUserDetails).listenable(),
          builder: (context, box, widget) {
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  return box.isEmpty
                      ? const Center(child: Text("No Items"))
                      : Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          margin: const EdgeInsets.symmetric(vertical: 10),
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
                                        box.putAt(
                                            index, "${addItemController.text}");
                                        // ref.read(listItemsProvider).add(addItemController.text);
                                        addItemController.clear();
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(msg: "Updated");
                                      },
                                      "Update",
                                      "Update Item",
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    box.deleteAt(index);
                                  },
                                  icon: const Icon(
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
        backgroundColor: appColors.primary,
        onPressed: () async {
          await dailogFunc(
            context,
            box,
            () {
              box.add("${addItemController.text}");
              // ref.read(listItemsProvider).add(addItemController.text);
              addItemController.clear();
              Navigator.pop(context);
              Fluttertoast.showToast(msg: "Added successful");
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
