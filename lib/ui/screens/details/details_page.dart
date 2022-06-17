import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tasky/models/tasks.dart';
import 'package:tasky/schemas/projects/schemas_projet.dart';
import 'package:tasky/ui/widgets/stateless_widgets/allstateless.dart';
import 'package:tasky/utils/palette.dart';

class DetailsProjectPAge extends StatelessWidget {
  final int? id;

  const DetailsProjectPAge({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final taskval = TaskModel();

    return Scaffold(
      backgroundColor: Palette.oxford,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            //expandedHeight: 100.0,
            floating: true,
            snap: true,
            backgroundColor: Palette.blue,
            flexibleSpace: FlexibleSpaceBar(
              title: MyText(
                label: "Tasky",
                fontSize: 25.0,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Subscription(
                    options: SubscriptionOptions(
                        document: gql(GetOneProjectSchema.getOneProjectJson),
                        variables: {"id": id}),
                    builder: (result) {
                      if (result.hasException) {
                        return Center(
                          child: MyText(
                              label: result.exception!.graphqlErrors[0].message
                                  .toString()),
                        );
                      }

                      if (result.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final myproject = result.data!["projects_by_pk"];
                      //print(myproject["name"]);
                      TextEditingController name = TextEditingController();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * .05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyText(
                                label: "Title: ${myproject["name"]}",
                                colors: Colors.white,
                                fontSize: 25.0,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          MyText(
                            colors: Colors.white,
                            label: myproject["description"],
                            textAlign: TextAlign.justify,
                            height: 1.8,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          MyText(
                            colors: Colors.white,
                            label:
                                "Date of begin: ${DateFormat.yMd().format(DateTime.parse(myproject["date_begin"]))}",
                            //textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          MyText(
                            colors: Colors.white,
                            label:
                                "Date of end: ${DateFormat.yMd().format(DateTime.parse(myproject["date_end"]))}",
                            //textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
