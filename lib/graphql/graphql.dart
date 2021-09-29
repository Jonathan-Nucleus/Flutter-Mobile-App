import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:localstorage/localstorage.dart';

class GraphQLConfiguration {
  // ignore: avoid_init_to_null
  static Link link = null;

  static HttpLink httpLink = HttpLink(
    'https://api.deepy.site/graphql',
  );

  static final LocalStorage storage = new LocalStorage('graphql');

  static void setToken(String token) {
    if (token != null && token != '') {
      storage.setItem('token', token);
    }
  }

  static void removeToken() {
    storage.deleteItem('token');
  }

  static Link getLink() {
    AuthLink alink = AuthLink(getToken: () {
      String token = storage.getItem('token');
      if (token == null) {
        return '';
      }
      return 'Bearer ' + token;
    });

    GraphQLConfiguration.link = alink.concat(GraphQLConfiguration.httpLink);
    return GraphQLConfiguration.link;
  }

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: getLink(),
      cache: GraphQLCache(),
    ),
  );
}
