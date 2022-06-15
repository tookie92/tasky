import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tasky/models/projects.dart';
import 'package:tasky/schemas/schemas.dart';

class UpdateProjectProvider extends ChangeNotifier {
  bool _status = false;
  String _message = "";

  bool get getStatus => _status;
  String get getMessage => _message;

  final EndPoint _point = EndPoint();

  void updateProject(int id, ProjectModel projectModel, int catId) async {
    _status = true;
    _message = "Please Wait ...";
    notifyListeners();

    ValueNotifier<GraphQLClient> myclient = _point.getClient();
    var client = myclient.value;

    QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(UpdateProjectSchema.updateProjectJson),
        variables: {
          "pk_columns": {"id": id},
          "set": {
            "name": projectModel.name,
            "description": projectModel.description,
            "date_begin": projectModel.dateBegin,
            "date_end": projectModel.dateEnd,
            "categorie_id": catId
          }
        },
      ),
    );

    if (result.hasException) {
      if (result.exception!.graphqlErrors.isEmpty) {
        _message = "No Internet";
      } else {
        _message = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      _message = "Project now Updated";
      _status = false;
      notifyListeners();
    }
  }

  void clear() {
    _message = "";
    notifyListeners();
  }
}
