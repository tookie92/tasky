class SubscriptionTaskSchemas {
  static String subscriptionTaskJson = r"""
subscription AllTasks{
  tasks{
     id
    name
    status
    description
    date_debut
    date_fin
    project_id
    __typename
  }
}

""";
}
