import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:tasky/models/data.dart';

import '../models/draggable_model.dart';

class KanbanProvider extends ChangeNotifier {
  List<DragAndDropList> contents = [];

  List<DragAndDropList> get getContent => contents;

  void initial() {
    contents = allLists.map(buildList).toList();
    notifyListeners();
  }

  DragAndDropList buildList(DraggableList list) => DragAndDropList(
        header: Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            list.header,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        children: list.items
            .map((item) => DragAndDropItem(
                  child: ListTile(
                    leading: Image.network(
                      item.urlImage,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.title),
                  ),
                ))
            .toList(),
      );
  onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    var movedItem = contents[oldListIndex].children.removeAt(oldItemIndex);
    contents[newListIndex].children.insert(newItemIndex, movedItem);
    notifyListeners();
  }

  onListReorder(int oldListIndex, int newListIndex) {
    var movedList = contents.removeAt(oldListIndex);
    contents.insert(newListIndex, movedList);
    notifyListeners();
  }
}
