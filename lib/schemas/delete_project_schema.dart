class DeleProjectSchema {
  static String deleteProjectJson = r"""

mutation DeleteProject($id:Int!){
  delete_projects_by_pk(id: $id){
    id
    name
    description
    date_end
    date_begin
    __typename
    tasks{
      id
      name
      description
    }
  }
}
""";
}
