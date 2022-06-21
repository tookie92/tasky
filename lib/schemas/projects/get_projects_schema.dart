class GetProjectSchema {
  static String getProjectJson = r"""
query AllProject{
  projects{
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
