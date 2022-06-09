import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/providers/get_list_projects.dart';
import 'package:tasky/ui/widgets/my_text.dart';
import 'package:tasky/utils/palette.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      // color: Colors.green,
      height: size.height * .4,
      width: size.width,
      child: Consumer<GetProjectProvider>(
        builder: (context, task, child) {
          return ListView(
            padding: const EdgeInsets.all(0.0),
            children: List.generate(task.allTasks.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Container(
                  height: size.height * .1,
                  decoration: BoxDecoration(
                    color: Palette.mikado,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: MyText(
                      label: task.allTasks[index].name!,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                    subtitle: MyText(
                      label:
                          "From ${task.allTasks[index].dateDebut!} to ${task.allTasks[index].dateFin!} ",
                      fontSize: 12.0,
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
