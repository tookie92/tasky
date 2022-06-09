import 'package:flutter/material.dart';
import 'package:tasky/models/projects.dart';
import 'package:tasky/models/tasks.dart';

class GetProjectProvider extends ChangeNotifier {
  final List<ProjectModel> allProjects = [
    ProjectModel(
        id: 1,
        name: "Valentin",
        description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      Modi tempora mollitia sit praesentium vel. 
      """,
        dateBegin: "12/05/2022",
        dateEnd: "13/05/2022",
        tasks: [
          TaskModel(
            id: 1,
            name: "Legacy Usability Producer",
            status: "active",
            description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
            dateDebut: "12/05/2022",
            dateFin: "13/05/2022",
          ),
          TaskModel(
            id: 2,
            name: "Legacy Usability Producer",
            status: "active",
            description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
            dateDebut: "12/05/2022",
            dateFin: "13/05/2022",
          ),
          TaskModel(
            id: 3,
            name: "Legacy Usability Producer",
            status: "active",
            description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
            dateDebut: "12/05/2022",
            dateFin: "13/05/2022",
          ),
          TaskModel(
            id: 5,
            name: "Legacy Usability Producer",
            status: "active",
            description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
            dateDebut: "12/05/2022",
            dateFin: "13/05/2022",
          ),
        ]),
    ProjectModel(
      id: 2,
      name: "Mitchel",
      description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      Modi tempora mollitia sit praesentium vel. 
      """,
      dateBegin: "12/05/2022",
      dateEnd: "13/05/2022",
      tasks: [
        TaskModel(
          id: 3,
          name: "Legacy Usability Producer",
          status: "active",
          description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
          dateDebut: "12/05/2022",
          dateFin: "13/05/2022",
        ),
        TaskModel(
          id: 5,
          name: "Legacy Usability Producer",
          status: "active",
          description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
          dateDebut: "12/05/2022",
          dateFin: "13/05/2022",
        ),
      ],
    ),
    ProjectModel(
      id: 3,
      name: "Erica",
      description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      Modi tempora mollitia sit praesentium vel. 
      """,
      dateBegin: "12/05/2022",
      dateEnd: "13/05/2022",
      tasks: [
        TaskModel(
          id: 1,
          name: "Legacy Usability Producer",
          status: "active",
          description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
          dateDebut: "12/05/2022",
          dateFin: "13/05/2022",
        ),
        TaskModel(
          id: 2,
          name: "Legacy Usability Producer",
          status: "active",
          description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
          dateDebut: "12/05/2022",
          dateFin: "13/05/2022",
        ),
        TaskModel(
          id: 5,
          name: "Legacy Usability Producer",
          status: "active",
          description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
          dateDebut: "12/05/2022",
          dateFin: "13/05/2022",
        ),
      ],
    ),
    ProjectModel(
      id: 4,
      name: "Alene",
      description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      Modi tempora mollitia sit praesentium vel. 
      """,
      dateBegin: "12/05/2022",
      dateEnd: "13/05/2022",
      tasks: [
        TaskModel(
          id: 5,
          name: "Legacy Usability Producer",
          status: "active",
          description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
          dateDebut: "12/05/2022",
          dateFin: "13/05/2022",
        ),
      ],
    ),
    ProjectModel(
      id: 6,
      name: "Pansy",
      description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      Modi tempora mollitia sit praesentium vel. 
      """,
      dateBegin: "12/05/2022",
      dateEnd: "13/05/2022",
      tasks: [],
    ),
  ];

  List<TaskModel> allTasks = [
    TaskModel(
      id: 1,
      name: "Legacy Usability Producer",
      status: "active",
      description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
      dateDebut: "12/05/2022",
      dateFin: "13/05/2022",
    ),
    TaskModel(
      id: 2,
      name: "Legacy Usability Producer",
      status: "active",
      description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
      dateDebut: "12/05/2022",
      dateFin: "13/05/2022",
    ),
    TaskModel(
      id: 3,
      name: "Legacy Usability Producer",
      status: "active",
      description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
      dateDebut: "12/05/2022",
      dateFin: "13/05/2022",
    ),
    TaskModel(
      id: 5,
      name: "Legacy Usability Producer",
      status: "active",
      description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
      dateDebut: "12/05/2022",
      dateFin: "13/05/2022",
    ),
    TaskModel(
      id: 5,
      name: "Legacy Usability Producer",
      status: "active",
      description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
      dateDebut: "12/05/2022",
      dateFin: "13/05/2022",
    ),
    TaskModel(
      id: 5,
      name: "Legacy Usability Producer",
      status: "active",
      description: r"""
      Laboriosam incidunt non neque impedit tempore est fugiat repellat impedit.
      """,
      dateDebut: "12/05/2022",
      dateFin: "13/05/2022",
    ),
  ];

  List<ProjectModel> get getProjects => allProjects;
  List<TaskModel> get getTasks => allTasks;
}
