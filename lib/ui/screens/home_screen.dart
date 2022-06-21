import 'package:flutter/material.dart';
import 'package:tasky/utils/palette.dart';

import '../lists/lists.dart';
import '../widgets/stateless_widgets/allstateless.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(
            height: size.height * .02,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyText(
                label: "Your Projects",
                fontSize: 15.0,
                colors: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/addPage");
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Palette.pumpkin,
                    size: 15.0,
                  )),
              SizedBox(
                width: size.width * .34,
              ),
              TextButton(
                onPressed: (() {}),
                child: const MyText(label: "See all"),
              )
            ],
          ),
          const SizedBox(height: 20.0),
          const ProjectList(),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              MyText(
                label: "Your tasks",
                fontSize: 18.0,
                colors: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const TaskList()
        ],
      ),
    );
  }
}
