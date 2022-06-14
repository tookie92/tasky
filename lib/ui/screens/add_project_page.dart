import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tasky/models/projects.dart';
import 'package:tasky/schemas/all_categories_schema.dart';
import 'package:tasky/ui/widgets/stateless_widgets/allstateless.dart';
import 'package:tasky/utils/palette.dart';

import '../../providers/add_project_provider.dart';

class AddProjectPage extends StatelessWidget {
  const AddProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fields = ProjectModel();
    String? myselectedValue = "A";

    final formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Palette.oxford,
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              backgroundColor: Palette.blue,
              floating: true,
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                title: MyText(label: "Add a blaan"),
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
                        forValidator: "Please Insert a name",
                        onSaved: (newValue) => fields.name = newValue,
                        labelText: "Name",
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      MyTextForm(
                        forValidator: "Please Insert a description",
                        onSaved: (newValue) => fields.description = newValue,
                        labelText: "Description",
                        maxLines: 4,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      MyDateField(
                        initialDate: DateTime.now(),
                        labelText: "Date of begin",
                        onSaved: (newValue) => fields.dateBegin = newValue,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      MyDateField(
                        initialDate:
                            DateTime.now().add(const Duration(days: 2)),
                        labelText: "Date of end",
                        onSaved: (newValue) => fields.dateEnd = newValue,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      //Query for categorie
                      Query(
                        options: QueryOptions(
                            document:
                                gql(GetCategoriesSchema.getCategoriesJson)),
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
                      ),
                      Consumer<AddProjectProvider>(
                        builder: (context, add, child) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (add.getMessage != "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: MyText(label: add.getMessage)));
                              add.clear();
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
                                onTap: add.getStatus == true
                                    ? null
                                    : (() {
                                        if (formKey.currentState!.validate()) {
                                          formKey.currentState!.save();

                                          var c = int.parse(myselectedValue!);
                                          print(" $fields, $myselectedValue");

                                          add.addProject(fields, c);
                                        }
                                      }),
                                child: Container(
                                  padding: const EdgeInsets.all(15.0),
                                  margin: const EdgeInsets.all(30),
                                  decoration: const BoxDecoration(
                                      color: Palette.pumpkin),
                                  child: Text(add.getStatus == true
                                      ? "Loading"
                                      : "Save"),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
