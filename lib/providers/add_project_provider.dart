import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tasky/models/projects.dart';
import 'package:tasky/schemas/url_endpoint.dart';

import '../schemas/projects/schemas_projet.dart';

class AddProjectProvider extends ChangeNotifier {
  bool _status = false;
  String _message = "";

  String get getMessage => _message;
  bool get getStatus => _status;

  final EndPoint _point = EndPoint();

  void addProject(ProjectModel projectModel, int catId) async {
    _status = true;
    _message = 'Please wait ....';
    notifyListeners();

    ValueNotifier<GraphQLClient> client = _point.getClient();

    QueryResult resulte = await client.value.query(
      QueryOptions(
        document: gql(GetTaskSchema.getTaskJson),
      ),
    );

    QueryResult result = await client.value.mutate(
      MutationOptions(
        document: gql(AddProjectSchema.addProjectSchemaJson),
        variables: {
          "object": {
            "name": projectModel.name,
            "description": projectModel.description,
            "date_begin": projectModel.dateBegin,
            "date_end": projectModel.dateEnd,
            "categorie_id": catId,
          }
        },
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
      // var request = Request(
      //     operation: Operation(document: gql(GetTaskSchema.getTaskJson)));

      // final newElememt = result.data!["insert_projects_one"];
      // final data = client.value.cache.readQuery(request);
      // final List items = data!["projects"]..insert(0, newElememt);

      // data["projects"] = items;

      // client.value.cache.writeQuery(request, data: data);
      _message = "Client Added";
      _status = false;
      notifyListeners();
    }
  }

  void clear() {
    _message = "";

    notifyListeners();
  }
}
