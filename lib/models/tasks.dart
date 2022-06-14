class TaskModel {
  String? name;
  String? status;
  String? description;
  String? dateDebut;
  String? dateFin;

  List<Map<String, String>>? tasks;

  @override
  String toString() =>
      "$name, $status, $description, $dateDebut, $dateFin, $tasks";
}
