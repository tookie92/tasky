class SubscriptionTaskWhereSchemas {
  static String subscriptionTaskWhereJson = r"""
subscription AllTasks($where: tasks_bool_exp){
  tasks(where: $where){
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
