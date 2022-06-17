import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:tasky/providers/all_providers.dart';
import 'package:tasky/schemas/url_endpoint.dart';
import 'package:tasky/ui/screens/add_project_page.dart';
import 'package:tasky/ui/screens/bienvenue.dart';
import 'package:tasky/ui/screens/home_page.dart';

void main() {
  initializeDateFormatting('fr', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final EndPoint endPoint = EndPoint();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetProjectProvider()),
        ChangeNotifierProvider(create: (_) => AddProjectProvider()),
        ChangeNotifierProvider(create: (_) => DeleteProjectProvider()),
        ChangeNotifierProvider(create: (_) => NestedFormProvider()),
        ChangeNotifierProvider(create: (_) => UpdateProjectProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: GraphQLProvider(
        client: endPoint.getClient(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: "/",
          routes: {
            "/": (context) => const BienVenuePage(),
            "/homepage": (context) => const MyHomePage(),
            "/addPage": (context) => const AddProjectPage(),
          },
        ),
      ),
    );
  }
}
