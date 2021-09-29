import 'package:flutter/material.dart';
import 'package:client/routes/routes.dart';
import 'package:client/screens/start/login.dart';
import 'package:client/graphql/graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLConfiguration graphQLConfig = GraphQLConfiguration();
void main() => runApp(
      GraphQLProvider(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Login(),
            onGenerateRoute: Routes.generateRoute,
          ),
          client: graphQLConfig.client),
    );
