import 'package:flutter/material.dart';
import 'package:tasky/ui/screens/tabs/calendar_page.dart';
import 'package:tasky/ui/screens/tabs/home_screen.dart';
import 'package:tasky/ui/screens/tabs/kanban_tab.dart';
import 'package:tasky/ui/widgets/stateless_widgets/allstateless.dart';

class NavigationProvider extends ChangeNotifier {
  int currentIndex = 0;

  final screens = [
    const HomeScreen(),
    const CalendarPage(),
    const KanbanTab(),
    const Center(
      child: MyText(
        label: "quatre",
        fontSize: 30.0,
      ),
    ),
  ];

  get getList => screens;

  int get getIndex => currentIndex;

  currentTab(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
