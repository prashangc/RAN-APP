import 'package:app/bottomNavigationPages/ProgramsBottomNavigation.dart';
import 'package:app/bottomNavigationPages/HomeBottomNavigation.dart';
import 'package:app/bottomNavigationPages/BlogsBottomNavigation.dart';
import 'package:app/bottomNavigationPages/RanMembersBottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final screens = [
    const HomeBottomNavigation(),
    const RanMembersBottomNavigation(),
    const BlogsBottomNavigation(),
    const ProgramsBottomNavigation(),
    // AppDrawer(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          height: double.infinity,
          child: IndexedStack(
            index: _currentIndex,
            children: screens,
            // child: screens[_currentIndex]
          ),
        ),
        bottomNavigationBar: Builder(
          builder: (BuildContext context) {
            return BottomAppBar(
              shape: const AutomaticNotchedShape(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                    icon: SvgPicture.asset(
                      'assets/home.svg',
                      color: _currentIndex == 0 ? Colors.black : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    icon: SvgPicture.asset(
                      'assets/gallery.svg',
                      color: _currentIndex == 1 ? Colors.black : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                    icon: SvgPicture.asset(
                      'assets/blog.svg',
                      color: _currentIndex == 2 ? Colors.black : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                    icon: SvgPicture.asset(
                      'assets/projects.svg',
                      color: _currentIndex == 3 ? Colors.black : Colors.grey,
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.menu),
                      color: _currentIndex == 4 ? Colors.black : Colors.grey,
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      }),
                ],
              ),
            );
          },
        ),
        endDrawer: AppDrawer());
  }
}
