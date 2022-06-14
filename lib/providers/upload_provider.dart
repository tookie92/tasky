import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tasky/schemas/schemas.dart';
import "package:http/http.dart" show MultipartFile;
import 'package:http_parser/http_parser.dart';

class UploadProvider extends ChangeNotifier {
  dynamic _file;

  dynamic get getFile => _file;

  final EndPoint _point = EndPoint();

  void uploadtheFile() async {
    final myFile = MultipartFile.fromString(
      "",
      "just plain text",
      filename: "sample_text.txt",
      contentType: MediaType("text", "plain"),
    );

    ValueNotifier<GraphQLClient> client = _point.getClient();

    QueryResult result = await client.value.mutate(
        MutationOptions(document: gql(UploadSchema.uploadJson), variables: {
      "files": [myFile],
    }));

    if (result.hasException) {
      print(result.exception!.graphqlErrors[0].message.toString());
      notifyListeners();
    } else {
      print(result.data);
    }
  }
}
