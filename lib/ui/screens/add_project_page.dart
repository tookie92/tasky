import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tasky/models/projects.dart';
import 'package:tasky/providers/add_project_provider.dart';
import 'package:tasky/providers/nested_forms.dart';
import 'package:tasky/schemas/projects/schemas_projet.dart';
import 'package:tasky/ui/widgets/stateless_widgets/allstateless.dart';
import 'package:tasky/utils/palette.dart';

class AddProjectPage extends StatelessWidget {
  const AddProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fields = ProjectModel();
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    String? myselectedValue = "1";
    final formKey = context.watch<NestedFormProvider>().getFormKey;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Palette.oxford,
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              backgroundColor: Palette.blue,
              flexibleSpace: FlexibleSpaceBar(
                title: MyText(label: "Add a project"),
              ),
            ),
            Form(
              key: formKey,
              child: SliverToBoxAdapter(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (!isKeyboard)
                          const SizedBox(
                            height: 50.0,
                          ),
                        MyTextForm(
                          labelText: "Name",
                          forValidator: "Please enter a name",
                          onSaved: (newValue) => fields.name = newValue,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        MyTextForm(
                          labelText: "Description",
                          maxLines: 3,
                          forValidator: "Please enter a description",
                          onSaved: (newValue) => fields.description = newValue,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        MyDateField(
                          labelDate: "Date of Begin",
                          initialDate: DateTime.now(),
                          onSaved: (newValue) => fields.dateBegin = newValue,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        MyDateField(
                          labelDate: "Date of End",
                          initialDate:
                              DateTime.now().add(const Duration(days: 1)),
                          onSaved: (newValue) => fields.dateEnd = newValue,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Query(
                          options: QueryOptions(
                              document:
                                  gql(GetCategoriesSchema.getCategoriesJson)),
                          builder: (result, {refetch, fetchMore}) {
                            if (result.hasException) {
                              if (result.exception!.graphqlErrors.isEmpty) {
                                return const Center(
                                  child: MyText(label: "No iternet"),
                                );
                              } else {
                                return Center(
                                    child: MyText(
                                  label: result
                                      .exception!.graphqlErrors[0].message
                                      .toString(),
                                ));
                              }
                            }

                            if (result.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Palette.pumpkin,
                                ),
                              );
                            }

                            return MyDropdownField(
                              labelText: "Categories",
                              onChanged: (newValue) =>
                                  myselectedValue = newValue,
                              items: result.data!["categories"]
                                  .map<DropdownMenuItem<String>>(
                                (e) {
                                  return DropdownMenuItem<String>(
                                    value: e["id"].toString(),
                                    child: MyText(label: e["name"]),
                                  );
                                },
                              ).toList(),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Consumer<AddProjectProvider>(
                          builder: ((context, add, child) {
                            WidgetsBinding.instance.addPostFrameCallback(
                              (_) {
                                if (add.getMessage != "") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: MyText(
                                    label: add.getMessage,
                                    colors: Colors.white,
                                  )));
                                  add.clear();
                                }
                              },
                            );
                            return MyTextButton(
                              onPressed: add.getStatus == true
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        var id = int.parse(myselectedValue!);
                                        print(fields);
                                        add.addProject(fields, id);
                                      }
                                    },
                              label:
                                  add.getStatus == true ? "Loading" : "Submit",
                              backgroundColor: Palette.pumpkin,
                              horizontal: 30.0,
                              primary: Colors.white,
                            );
                          }),
                        ),
                        Padding(
                            // this is new
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom *
                                        .95)),
                      ],
                    ),
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
