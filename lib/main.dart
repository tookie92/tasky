import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/providers/get_list_projects.dart';
import 'package:tasky/ui/screens/bienvenue.dart';
import 'package:tasky/ui/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GetProjectProvider(),
        )
      ],
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
        },
      ),
    );
  }
}
