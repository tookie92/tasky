class GetOneProjectSchema {
  static String getOneProjectJson = r"""
subscription AllProject($id: Int!){
  projects_by_pk(id: $id){
    id
    name
    description
    date_begin
    date_end
    categorie_id
    __typename
  }
}
""";
}
