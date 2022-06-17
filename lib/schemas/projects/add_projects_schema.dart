class AddProjectSchema {
  static String addProjectSchemaJson = r"""
mutation AddProjects($object: projects_insert_input!){
  insert_projects_one(object: $object){
    id
    name
    description
    date_begin
    date_end
    __typename
    tasks{
      id
      name
      description
      status
      date_debut
      date_fin
      __typename
    }
  }
}
""";
}
