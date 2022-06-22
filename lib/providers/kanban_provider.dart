import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:flutter/material.dart';

import '../ui/widgets/stateless_widgets/allstateless.dart';

class KanbanProvider extends ChangeNotifier {
  List<DragAndDropList>? _icontents =;
  List<DragAndDropList> _contents = List.generate(3, (index) {
    return DragAndDropList(
      header: MyText(colors: Colors.white, label: 'Header $index'),
      children: <DragAndDropItem>[
        DragAndDropItem(
          child: MyText(colors: Colors.white, label: '$index.1'),
        ),
        DragAndDropItem(
          child: MyText(colors: Colors.white, label: '$index.2'),
        ),
        DragAndDropItem(
          child: MyText(colors: Colors.white, label: '$index.3'),
        ),
      ],
    );
  });

  List<DragAndDropList> get getContent => _contents;

  void initial() {
    _contents = List.generate(3, (index) {
      return DragAndDropList(
        header: MyText(colors: Colors.white, label: 'Header $index'),
        children: <DragAndDropItem>[
          DragAndDropItem(
            child: MyText(colors: Colors.white, label: '$index.1'),
          ),
          DragAndDropItem(
            child: MyText(colors: Colors.white, label: '$index.2'),
          ),
          DragAndDropItem(
            child: MyText(colors: Colors.white, label: '$index.3'),
          ),
        ],
      );
    });

    notifyListeners();
  }

  dynamic getAll() {
    if (_icontents!.isNotEmpty) {
      final data = _icontents;

      return data;
    } else {
      return <DragAndDropListInterface>[];
    }
  }

  List<DragAndDropList> getAlli() {
    List<DragAndDropList> ocontents = [];

    ocontents.add(DragAndDropList(
        header: const MyText(label: "hewader"),
        children: <DragAndDropItem>[
          DragAndDropItem(
            child: const MyText(colors: Colors.white, label: '1'),
          ),
          DragAndDropItem(
            child: const MyText(colors: Colors.white, label: '2'),
          ),
          DragAndDropItem(
            child: const MyText(colors: Colors.white, label: '3'),
          ),
        ]));
  
  }

  onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    var movedItem = _icontents![oldListIndex].children.removeAt(oldItemIndex);
    _icontents![newListIndex].children.insert(newItemIndex, movedItem);
    notifyListeners();
  }

  onListReorder(int oldListIndex, int newListIndex) {
    var movedList = _icontents!.removeAt(oldListIndex);
    _icontents!.insert(newListIndex, movedList);
    notifyListeners();
  }
}
