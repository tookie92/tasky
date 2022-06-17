import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/ui/widgets/stateless_widgets/my_text.dart';
import 'package:tasky/utils/palette.dart';

import '../../providers/all_providers.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int currentIndex = 0;

    return Scaffold(
      backgroundColor: Palette.oxford,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Palette.blue,
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
                    colors: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                  ),
                  CircleAvatar(
                    backgroundColor: Palette.oxford,
                    backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/428361/pexels-photo-428361.jpeg?cs=srgb&dl=pexels-spencer-selover-428361.jpg&fm=jpg",
                    ),
                    radius: 10.0,
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: IndexedStack(
                index: context.watch<NavigationProvider>().getIndex,
                children: context.watch<NavigationProvider>().getList,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Palette.pumpkin,
          iconTheme: MaterialStateProperty.all(
            const IconThemeData(color: Colors.white),
          ),
        ),
        child: NavigationBar(
          height: 60.0,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          animationDuration: const Duration(seconds: 2),
          backgroundColor: Palette.blue,
          onDestinationSelected: (index) {
            context.read<NavigationProvider>().currentTab(index);
          },
          selectedIndex: context.watch<NavigationProvider>().getIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_filled),
              label: "home",
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border_outlined),
              selectedIcon: Icon(Icons.favorite_sharp),
              label: "home",
            ),
            NavigationDestination(
              icon: Icon(Icons.home),
              label: "home",
            ),
            NavigationDestination(
              icon: Icon(Icons.home),
              label: "home",
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Palette.blue,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   unselectedItemColor: Colors.white,
      //   selectedItemColor: Palette.pumpkin,
      //   onTap: (index) {
      //     context.read<NavigationProvider>().currentTab(index);
      //   },
      //   currentIndex: context.watch<NavigationProvider>().getIndex,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: "home",
      //       backgroundColor: Palette.blue,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: "other",
      //       backgroundColor: Palette.blue,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.chat),
      //       label: "chat",
      //       backgroundColor: Palette.blue,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: "person",
      //       backgroundColor: Palette.blue,
      //     ),
      //   ],
      // ),
    );
  }
}
