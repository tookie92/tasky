import 'package:flutter/material.dart';
import 'package:tasky/ui/widgets/stateless_widgets/my_text.dart';

class NavigationDestination extends StatelessWidget {
  final IconData? icons;
  final String? label;
  const NavigationDestination({Key? key, this.icons, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icons ?? Icons.home),
        MyText(label: label ?? "no label "),
      ],
    );
  }
}
