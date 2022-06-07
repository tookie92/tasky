import 'package:flutter/material.dart';
import 'package:tasky/ui/widgets/my_text.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 60.0,
            floating: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  MyText(
                    label: "Hey Joseph",
                    colors: Colors.deepPurple,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    backgroundImage: NetworkImage(
                        "https://images.pexels.com/photos/428361/pexels-photo-428361.jpeg?cs=srgb&dl=pexels-spencer-selover-428361.jpg&fm=jpg"),
                    radius: 10.0,
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyText(
                        label: "Your Projects",
                        colors: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      TextButton(
                          onPressed: (() {}),
                          child: const MyText(label: "See all"))
                    ],
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
