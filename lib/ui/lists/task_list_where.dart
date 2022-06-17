import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tasky/schemas/tasks/schema_tasks.dart';
import 'package:tasky/ui/widgets/stateless_widgets/allstateless.dart';
import 'package:tasky/utils/palette.dart';

class TaskListWhere extends StatelessWidget {
  final int? id;
  const TaskListWhere({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      // color: Colors.green,
      height: size.height * .4,
      width: size.width,
      child: Subscription(
        options: SubscriptionOptions(
            document:
                gql(SubscriptionTaskWhereSchemas.subscriptionTaskWhereJson),
            variables: {
              "where": {
                "project_id": {
                  "_eq": id,
                }
              }
            }),
        builder: (result) {
          if (result.hasException) {
            return Center(
              child: MyText(
                label: result.exception!.graphqlErrors[0].message.toString(),
              ),
            );
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Palette.pumpkin,
              ),
            );
          }

          final tasks = result.data!["tasks"];
          //return Container();
          return ListView(
            padding: const EdgeInsets.all(0.0),
            children: List.generate(tasks.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Slidable(
                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(onDismissed: () {}),

                    // All actions are defined in the children parameter.
                    children: const [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: null,
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: null,
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Share',
                      ),
                    ],
                  ),
                  endActionPane: const ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        // An action can be bigger than the others.
                        flex: 2,
                        onPressed: null,
                        backgroundColor: Color(0xFF7BC043),
                        foregroundColor: Colors.white,
                        icon: Icons.archive,
                        label: 'Archive',
                      ),
                      SlidableAction(
                        onPressed: null,
                        backgroundColor: Color(0xFF0392CF),
                        foregroundColor: Colors.white,
                        icon: Icons.save,
                        label: 'Save',
                      ),
                    ],
                  ),
                  child: Container(
                    height: size.height * .1,
                    decoration: const BoxDecoration(
                      color: Palette.mikado,
                      //borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      title: MyText(
                        label: tasks[index]["name"],
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                      subtitle: MyText(
                        label:
                            "From ${tasks[index]["date_debut"]} to ${tasks[index]["date_fin"]} ",
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
      // child: Consumer<GetProjectProvider>(
      //   builder: (context, task, child) {
      //     return ListView(
      //       padding: const EdgeInsets.all(0.0),
      //       children: List.generate(task.allTasks.length, (index) {
      //         return Padding(
      //           padding: const EdgeInsets.only(bottom: 20.0),
      //           child: Container(
      //             height: size.height * .1,
      //             decoration: BoxDecoration(
      //               color: Palette.mikado,
      //               borderRadius: BorderRadius.circular(10.0),
      //             ),
      //             child: ListTile(
      //               title: MyText(
      //                 label: task.allTasks[index].name!,
      //                 fontSize: 15.0,
      //                 fontWeight: FontWeight.w600,
      //               ),
      //               subtitle: MyText(
      //                 label:
      //                     "From ${task.allTasks[index].dateDebut!} to ${task.allTasks[index].dateFin!} ",
      //                 fontSize: 12.0,
      //               ),
      //             ),
      //           ),
      //         );
      //       }),
      //     );
      //   },
      // ),
    );
  }
}
