import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NestedFormProvider extends ChangeNotifier {
  final List<Map<String, String>> _fields = [];
  ValueChanged<List<Map<String, String>>> onUpdate = (value) {};
  final Uuid uuid = const Uuid();

  List<Map<String, String>> get getList => _fields;
  ValueChanged<List<Map<String, String>>> get getUpdate => onUpdate;
  Uuid get getUuid => uuid;

  void addField() {
    _fields.add({uuid.v1(): ''});

    notifyListeners();
  }

  void removeField(int index) {
    _fields.removeAt(index);
    onUpdate(_fields);
    notifyListeners();
  }

  void updatedFields(String? value, int index) {
    final key = _fields[index].keys.first;
    _fields[index][key] = value!;
    //print(_fields);
    onUpdate(_fields);
    notifyListeners();
  }
}
