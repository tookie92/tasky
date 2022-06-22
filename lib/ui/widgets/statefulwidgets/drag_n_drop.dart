import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:flutter/material.dart';

class MyDragAndDropList extends StatefulWidget {
  late List<DragAndDropList>? lists;
  MyDragAndDropList({Key? key, this.lists}) : super(key: key);

  @override
  State<MyDragAndDropList> createState() => _MyDragAndDropListState();
}

class _MyDragAndDropListState extends State<MyDragAndDropList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem =
          widget.lists![oldListIndex].children.removeAt(oldItemIndex);
      widget.lists![newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = widget.lists!.removeAt(oldListIndex);
      widget.lists!.insert(newListIndex, movedList);
    });
  }
}
