import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tasky/schemas/projects/schemas_projet.dart';

import '../schemas/url_endpoint.dart';

class DeleteProjectProvider extends ChangeNotifier {
  bool _status = false;
  String _message = "";

  bool get getStatus => _status;
  String get getMessage => _message;

  final EndPoint endPoint = EndPoint();

  void deleteProject(int id) async {
    _status = true;
    _message = "Please Wait..";

    notifyListeners();

    ValueNotifier<GraphQLClient> client = endPoint.getClient();

    QueryResult resulte = await client.value
        .query(QueryOptions(document: gql(GetTaskSchema.getTaskJson)));

    QueryResult result = await client.value.mutate(
      MutationOptions(
        document: gql(DeleProjectSchema.deleteProjectJson),
        variables: {"id": id},
      ),
    );

    if (result.hasException && resulte.hasException) {
      if (result.exception!.graphqlErrors.isEmpty) {
        _message = "No Internet";
      } else {
        _message = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      print(result.data);
      _message = "Client Delete";
      _status = false;
      notifyListeners();
    }
  }

  void clear() {
    _message = "";
    notifyListeners();
  }
}
