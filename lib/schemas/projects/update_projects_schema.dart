class UpdateProjectSchema {
  static String updateProjectJson = r"""
mutation updateProjects($pk_columns: projects_pk_columns_input!,$set: projects_set_input){
  update_projects_by_pk(pk_columns: $pk_columns, _set: $set){
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
