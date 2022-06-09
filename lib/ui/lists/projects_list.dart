import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tasky/providers/get_list_projects.dart';
import 'package:tasky/ui/widgets/my_text.dart';
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
      child: Consumer<GetProjectProvider>(builder: (context, proje, child) {
        return ListView(
            padding: const EdgeInsets.all(0.0),
            scrollDirection: Axis.horizontal,
            children: List.generate(proje.getProjects.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      width: size.width * .5,
                    ),
                    Container(
                      height: size.height * .18,
                      width: size.width * .5,
                      decoration: const BoxDecoration(
                        color: Palette.gold,
                        borderRadius: BorderRadius.only(
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
                            label: proje.getProjects[index].name!,
                            colors: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          MyText(
                            label: proje.getProjects[index].tasks!.isNotEmpty
                                ? "${proje.allProjects[index].tasks!.length} projets"
                                : "No Projects",
                            colors: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 10.0,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 40.0,
                      child: LinearPercentIndicator(
                        progressColor: Palette.pumpkin,
                        width: 190.0,
                        lineHeight: 10.0,
                        percent: 0.5,
                        barRadius: const Radius.circular(10.0),
                        backgroundColor: Colors.grey,
                      ),
                    )
                  ],
                ),
              );
            }));
      }),
    );
  }
}