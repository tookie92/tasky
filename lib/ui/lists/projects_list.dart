import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tasky/providers/all_providers.dart';
import 'package:tasky/schemas/subscription_project_schema.dart';
import 'package:tasky/ui/widgets/stateless_widgets/allstateless.dart';
import 'package:tasky/utils/palette.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      // color: Colors.white,
      height: size.height * .27,
      width: size.width,
      child: Subscription(
        options: SubscriptionOptions(
          document: gql(SubscriptionProjectSchema.subscriptionProjectSchema),
        ),
        builder: (result) {
          if (result.hasException) {
            return Center(
              child: Text(result.exception!.graphqlErrors[0].message),
            );
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Palette.pumpkin),
            );
          }

          final project = result.data!["projects"];

          if (project.isEmpty) {
            return const Center(
                child: MyText(
              fontSize: 20.0,
              colors: Palette.pumpkin,
              fontWeight: FontWeight.w600,
              label: "No Projects",
            ));
          }
          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(0.0),
            scrollDirection: Axis.horizontal,
            children: List.generate(project.length, (index) {
              Color? colore;
              switch (project[index]["categorie_id"]) {
                case 1:
                  colore = Palette.blue;
                  break;
                case 2:
                  colore = Palette.pumpkin;
                  break;
                case 3:
                  colore = Palette.black;
                  break;
                default:
                  colore = Colors.red;
              }
              return GestureDetector(
                onDoubleTap: () {
                  _showMyDialog(
                      context, project[index]["id"], project[index]["name"]);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(1.0, 2.0),
                              blurRadius: 5.0,
                              spreadRadius: 2.0,
                            )
                          ],
                        ),
                        height: size.height * .25,
                        width: size.width * .6,
                      ),
                      Container(
                        height: size.height * .18,
                        width: size.width * .6,
                        decoration: BoxDecoration(
                          color: colore,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                        ),
                      ),
                      Positioned(
                        top: size.height * .03,
                        left: size.width * .05,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Icon(
                                Icons.abc_sharp,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            MyText(
                              label: project[index]["name"],
                              colors: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            MyText(
                              label:
                                  "from ${DateFormat('d.MM.yy').format(DateTime.parse(project[index]["date_begin"]))} to ${DateFormat('d.MM.yy').format(DateTime.parse(project[index]["date_end"]))}",
                              colors: Palette.oxford,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.0,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 35.0,
                        child: Column(
                          children: [
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  width: 145.0,
                                ),
                                MyText(
                                    fontWeight: FontWeight.w600,
                                    label: project[index]["tasks"].isEmpty
                                        ? " No Tasks"
                                        : "${project[index]["tasks"].length.toString()} Tasks")
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            // LinearPercentIndicator(
                            //   progressColor: Palette.pumpkin,
                            //   width: 190.0,
                            //   lineHeight: 10.0,
                            //   percent: 0.1,
                            //   barRadius: const Radius.circular(10.0),
                            //   backgroundColor: Colors.grey,
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).reversed.toList(),
          );
        },
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context, int id, String? name) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const MyText(label: 'Do you want to delete'),
                Text(name!),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                context.read<DeleteProjectProvider>().deleteProject(id);
              },
            ),
          ],
        );
      },
    );
  }
}
