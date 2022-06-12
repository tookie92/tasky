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
          // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            const SliverAppBar(
              backgroundColor: Palette.blue,
              expandedHeight: 50.0,
              floating: true,
              snap: true,
              title: MyText(label: "Add a Project"),
            ),
            Form(
              key: formKey,
              child: SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50.0,
                      ),
                      const MyText(
                        label: "Product Identity Developer",
                        colors: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      MyTextForm(
                        labelText: "Name",
                        forValidator: "Please Enter a Name",
                        onSaved: (newValue) => fields.name = newValue,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      MyTextForm(
                        maxLines: 3,
                        labelText: "Description",
                        forValidator: "Please Enter a Description",
                        onSaved: (newValue) => fields.description = newValue,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      MyDateField(
                        onSaved: (newVal) => fields.dateBegin = newVal,
                        initialDate: DateTime.now(),
                        labelText: "Date of Begining",
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      MyDateField(
                        onSaved: (newVal) => fields.dateEnd = newVal,
                        initialDate:
                            DateTime.now().add(const Duration(days: 2)),
                        labelText: "End of the Project",
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
                          })
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Consumer<AddProjectProvider>(
                builder: (context, add, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (add.getMessage != '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(add.getMessage)));

                      add.clear();
                    }
                  });
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextButton(
                          onPressed: add.getStatus == true
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    print("$myselectedValue , $fields");
                                    var id = int.parse(myselectedValue!);
                                    add.addProvider(fields, id);
                                    formKey.currentState!.reset();
                                  }
                                },
                          label: add.getStatus == true ? "Loading" : "Save"),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
