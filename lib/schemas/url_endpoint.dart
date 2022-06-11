import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tasky/utils/endpoint.dart';

class EndPoint {
  ValueNotifier<GraphQLClient> getClient() {
    final HttpLink httpLink = HttpLink(
      endpointUrl,
      defaultHeaders: {"x-hasura-admin-secret": secret},
    );

    final WebSocketLink webSocketLink = WebSocketLink(
      socket,
      config: const SocketClientConfig(
        autoReconnect: true,
        headers: {"x-hasura-admin-secret": secret},
        inactivityTimeout: Duration(seconds: 30),
      ),
    );

    final Link link = Link.split(
        (request) => request.isSubscription, webSocketLink, httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(cache: GraphQLCache(), link: link),
    );

    return client;
  }
}
