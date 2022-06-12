class GetCategoriesSchema {
  static String getCategoriesJson = r"""
query AllCategorie{
  categories{
    id
    name
    description
    __typename
  }
}
""";
}
