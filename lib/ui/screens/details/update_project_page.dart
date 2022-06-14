import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tasky/models/projects.dart';
import 'package:tasky/providers/all_providers.dart';
import 'package:tasky/utils/palette.dart';

import '../../../schemas/schemas.dart';
import '../../widgets/stateless_widgets/allstateless.dart';

class UpdateProjectPage extends StatelessWidget {
  final int? id;
  const UpdateProjectPage({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final fields = ProjectModel();
    return Scaffold(
      backgroundColor: Palette.oxford,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Subscription(
            options: SubscriptionOptions(
                document: gql(GetOneProjectSchema.getOneProjectJson),
                variables: {
                  "id": id,
                }),
            builder: (result) {
              if (result.hasException) {
                return Center(
                  child: MyText(
                    label:
                        result.exception!.graphqlErrors[0].message.toString(),
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

              final project = result.data!["projects_by_pk"];
              String? myselectedValue = project["categorie_id"].toString();

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Palette.blue,
                    floating: true,
                    snap: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: MyText(label: "Edit ${project["name"]}"),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 100.0,
                            ),
                            MyTextForm(
                              initialValue: project["name"],
                              forValidator: "Please Insert a name",
                              onSaved: (newValue) => fields.name = newValue,
                              labelText: "Name",
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            MyTextForm(
                              initialValue: project["description"],
                              forValidator: "Please Insert a description",
                              onSaved: (newValue) =>
                                  fields.description = newValue,
                              labelText: "Description",
                              maxLines: 4,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            MyDateField(
                              initialDate:
                                  DateTime.parse(project["date_begin"]),
                              initialValue: project["date_begin"],
                              labelText: "Date of begin",
                              onSaved: (newValue) =>
                                  fields.dateBegin = newValue,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            MyDateField(
                              initialDate: DateTime.parse(project["date_end"]),
                              initialValue: project["date_end"],
                              labelText: "Date of end",
                              onSaved: (newValue) => fields.dateEnd = newValue,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            //Query for categorie
                            Query(
                              options: QueryOptions(
                                  document: gql(
                                      GetCategoriesSchema.getCategoriesJson)),
                              builder: (result, {refetch, fetchMore}) {
                                if (result.hasException) {
                                  if (result.exception!.graphqlErrors.isEmpty) {
                                    return const Center(
                                      child: MyText(label: "No Internet"),
                                    );
                                  } else {
                                    return MyText(
                                        label: result
                                            .exception!.graphqlErrors[0].message
                                            .toString());
                                  }
                                }

                                if (result.isLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: Palette.pumpkin,
                                  ));
                                }

                                return MyDropdownField(
                                  initialValue: "${project["categorie_id"]}",
                                  labelText: "Categories",
                                  forValidator: "Please choose a categorie ",
                                  onChanged: (value) => myselectedValue = value,
                                  items: result.data!["categories"]
                                      .map<DropdownMenuItem<String>>(
                                    (e) {
                                      return DropdownMenuItem<String>(
                                        value: e["id"].toString(),
                                        child: MyText(label: "${e["name"]}"),
                                      );
                                    },
                                  ).toList(),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    child: Consumer<UpdateProjectProvider>(
                      builder: (context, update, child) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (update.getMessage != "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: MyText(label: update.getMessage)));
                            update.clear();
                          }
                        });
                        return Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // MyTextButton(
                            //   onPressed: () {
                            //     //var c = int.parse(myselectedValue!);
                            //     if (formKey.currentState!.validate()) {
                            //       formKey.currentState!.save();
                            //       print(
                            //           "$fields, ${project["id"]},$myselectedValue }");
                            //     }
                            //   },
                            //   label: "Save",
                            // ),
                            GestureDetector(
                              onTap: update.getStatus == true
                                  ? null
                                  : (() {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        print(
                                            "${project["id"]}, $fields, $myselectedValue");
                                        var c = int.parse(myselectedValue!);

                                        update.updateTask(
                                            project["id"], fields, c);
                                      }
                                    }),
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                margin: const EdgeInsets.all(30),
                                decoration:
                                    const BoxDecoration(color: Palette.pumpkin),
                                child: Text(update.getStatus == true
                                    ? "Loading"
                                    : "Save"),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
