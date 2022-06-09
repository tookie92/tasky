import 'package:flutter/material.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 200.0,
        height: 200.0,
        color: Colors.white,
        child: const Text("jo"),
      ),
    );
  }
}
