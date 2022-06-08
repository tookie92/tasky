import 'package:tasky/models/tasks.dart';

class ProjectModel {
  final String? id;
  final String? name;
  final String? description;
  final String? dateBegin;
  final String? dateEnd;
  final List<TaskModel>? tasks;

  ProjectModel({
    this.id,
    this.name,
    this.description,
    this.dateBegin,
    this.dateEnd,
    this.tasks,
  });
}
