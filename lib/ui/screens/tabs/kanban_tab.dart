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
          Future.delayed(const Duration(seconds: 3), () => isActive = true);
        }
      });
      return SizedBox(
        height: size.height,
        child: DragAndDropLists(
          children: value.getContent,
          onItemReorder: value.onItemReorder,
          onListReorder: value.onListReorder,
          axis: Axis.horizontal,
          listWidth: 250,
          listDraggingWidth: 250,
          listDecoration: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black45,
                spreadRadius: 3.0,
                blurRadius: 6.0,
                offset: Offset(2, 3),
              ),
            ],
          ),
          listPadding: const EdgeInsets.all(8.0),
        ),
      );
    });
  }
}
