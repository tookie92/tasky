import 'package:flutter/material.dart';
import 'package:tasky/models/projects.dart';
import 'package:tasky/ui/lists/projects_list.dart';
import 'package:tasky/ui/lists/tasks_list.dart';
import 'package:tasky/ui/widgets/stateless_widgets/my_text.dart';
import 'package:tasky/utils/palette.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fields = ProjectModel();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Palette.oxford),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Palette.blue,
              expandedHeight: 60.0,
              floating: true,
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    MyText(
                      label: "Hey Joseph",
                      colors: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                    ),
                    CircleAvatar(
                      backgroundColor: Palette.oxford,
                      backgroundImage: NetworkImage(
                          "https://images.pexels.com/photos/428361/pexels-photo-428361.jpeg?cs=srgb&dl=pexels-spencer-selover-428361.jpg&fm=jpg"),
                      radius: 10.0,
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
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
                            child: const MyText(label: "See all"))
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    const ProjectList(),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyText(
                          label: "Your tasks",
                          fontSize: 18.0,
                          colors: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        TextButton(
                            onPressed: (() {}),
                            child: const MyText(label: "See all"))
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const TaskList()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
