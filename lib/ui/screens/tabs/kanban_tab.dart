import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/providers/all_providers.dart';

class KanbanTab extends StatelessWidget {
  const KanbanTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isActive = false;
    final size = MediaQuery.of(context).size;
    return Consumer<KanbanProvider>(builder: (context, value, child) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isActive == false) {
          value.initial();
        }
      });
      //print(value.getContent);
      return SizedBox(
        height: size.height,
        child: DragAndDropLists(
          children: value.getAll(),
          onItemReorder: value.onItemReorder,
          onListReorder: value.onListReorder,
        ),
      );
    });
  }
}
