import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tasky/models/projects.dart';
import 'package:tasky/providers/all_providers.dart';
import 'package:tasky/schemas/projects/schemas_projet.dart';
import 'package:tasky/utils/palette.dart';

import '../../widgets/stateless_widgets/allstateless.dart';

class UpdateProjectPage extends StatelessWidget {
  final int? id;
  const UpdateProjectPage({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = context.watch<NestedFormProvider>().getFormKey;
    final fields = ProjectModel();
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
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
                        child: SingleChildScrollView(
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const SizedBox(
                                height: 50.0,
                              ),
                              MyTextForm(
                                initialValue: project["name"],
                                labelText: "Name",
                                onSaved: (newValue) => fields.name = newValue,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              MyTextForm(
                                initialValue: project["description"],
                                labelText: "Description",
                                maxLines: 3,
                                onSaved: (newValue) =>
                                    fields.description = newValue,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              MyDateField(
                                labelText: "Date of Begin",
                                initialDate:
                                    DateTime.parse(project["date_begin"]),
                                initialValue: project["date_begin"],
                                onSaved: (newValue) =>
                                    fields.dateBegin = newValue,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              MyDateField(
                                labelText: "Date of End",
                                initialDate:
                                    DateTime.parse(project["date_end"]),
                                initialValue: project["date_end"],
                                onSaved: (newValue) =>
                                    fields.dateEnd = newValue,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Query(
                                options: QueryOptions(
                                    document: gql(
                                        GetCategoriesSchema.getCategoriesJson)),
                                builder: (result, {refetch, fetchMore}) {
                                  if (result.hasException) {
                                    if (result
                                        .exception!.graphqlErrors.isEmpty) {
                                      return const Center(
                                        child: MyText(label: "No Internet"),
                                      );
                                    } else {
                                      return Center(
                                        child: MyText(
                                            label: result.exception!
                                                .graphqlErrors[0].message
                                                .toString()),
                                      );
                                    }
                                  }

                                  if (result.isLoading) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  return MyDropdownField(
                                    initialValue: "${project["categorie_id"]}",
                                    onChanged: (newValue) =>
                                        myselectedValue = newValue,
                                    items: result.data!["categories"]
                                        .map<DropdownMenuItem<String>>((e) {
                                      return DropdownMenuItem<String>(
                                        value: e["id"].toString(),
                                        child: MyText(label: e["name"]),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Consumer<UpdateProjectProvider>(
                                builder: ((context, update, child) {
                                  WidgetsBinding.instance.addPostFrameCallback(
                                    (_) {
                                      if (update.getMessage != "") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: MyText(
                                          label: update.getMessage,
                                          colors: Colors.white,
                                        )));
                                        update.clear();
                                      }
                                    },
                                  );
                                  return MyTextButton(
                                    onPressed: update.getStatus == true
                                        ? null
                                        : () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              formKey.currentState!.save();
                                              var id =
                                                  int.parse(myselectedValue!);
                                              update.updateProject(
                                                  project["id"], fields, id);
                                            }
                                          },
                                    label: update.getStatus == true
                                        ? "Loading"
                                        : "Submit",
                                    backgroundColor: Palette.pumpkin,
                                    horizontal: 30.0,
                                    primary: Colors.white,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              );
            }),
      ),
    );
  }
}
