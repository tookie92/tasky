class GetTaskSchema {
  static String getTaskJson = r"""
query AllProject{
  projects{
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
