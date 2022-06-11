class SubscriptionProjectSchema {
  static String subscriptionProjectSchema = r"""
subscription AllProject($limit: Int){
  projects(limit: $limit){
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
