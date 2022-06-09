import 'package:tasky/models/projects.dart';

class CategorieModel {
  final int? id;
  final String? name;
  final String? description;
  final List<ProjectModel>? projects;

  CategorieModel({
    this.id,
    this.name,
    this.description,
    this.projects,
  });
}
