import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/models/projects.dart';
import 'package:tasky/ui/widgets/stateless_widgets/allstateless.dart';
import 'package:tasky/utils/palette.dart';

import '../../providers/add_project_provider.dart';

class AddProjectPage extends StatelessWidget {
  const AddProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final fields = ProjectModel();
    final FocusScopeNode node = FocusScopeNode();
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
                      MyTextForm(
                        labelText: "Beginning",
                        forValidator: "Please Enter a Description",
                        onSaved: (newValue) => fields.dateBegin = newValue,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      MyTextForm(
                        labelText: "End",
                        forValidator: "Please Enter a Description",
                        onSaved: (newValue) => fields.description = newValue,
                      ),
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
                                    print(fields);
                                    //add.addProvider(fields, 2);
                                    //formKey.currentState!.reset();
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
