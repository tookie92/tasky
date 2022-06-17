class AddTaskSchema {
  static String addTaskJson = r"""
mutation AddTask($object: tasks_insert_input!){
  insert_tasks_one(object: $object){
    id
    name
    status
    description
    date_debut
    date_fin
    project_id
  }
}
""";
}
