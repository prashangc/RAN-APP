import 'package:app/appbarScreeen/AllProgramsList.dart';
import 'package:app/appbarScreeen/AllProjectsList.dart';
import 'package:app/appbarScreeen/Collaborators.dart';
import 'package:app/appbarScreeen/Gallery.dart';
import 'package:app/bottomNavigationPages/RanMembersBottomNavigation.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/login_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localstorage/localstorage.dart';

import '../appbarScreeen/AboutUs.dart';
import '../appbarScreeen/AllServicesList.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage("usertoken");
    _logoutnow() {
      storage.clear();
      Navigator.of(context).pushReplacementNamed(LoginRegisterScreen.routeName);
    }

    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 100.0),
        color: Colors.white,
        width: width,
        height: height,
        child: ListView(children: [
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            leading: SvgPicture.asset(
              'assets/home.svg',
              height: 20,
              width: 20,
            ),
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AllServicesList()),
              );
            },
            leading: SvgPicture.asset(
              'assets/home.svg',
              height: 20,
              width: 20,
            ),
            title: const Text(
              "Services",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AllProgramsList()),
              );
            },
            leading: SvgPicture.asset(
              'assets/programs.svg',
              height: 26,
              width: 26,
            ),
            title: const Text(
              "Programs",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AllProjectsList()),
              );
            },
            leading: SvgPicture.asset(
              'assets/projects.svg',
              height: 26,
              width: 26,
            ),
            title: const Text(
              "Projects",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Gallery()),
              );
            },
            leading: SvgPicture.asset(
              'assets/gallery.svg',
              height: 22,
              width: 22,
            ),
            title: const Text(
              "Gallery",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RanMembersBottomNavigation()),
              );
            },
            leading: SvgPicture.asset(
              'assets/ranfamily.svg',
              height: 21,
              width: 21,
            ),
            title: const Text(
              "RAN Family",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Collaborators()),
              );
            },
            leading: SvgPicture.asset(
              'assets/collaborators.svg',
              height: 22,
              width: 22,
            ),
            title: const Text(
              "Collaborators",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUs()),
              );
            },
            leading: SvgPicture.asset(
              'assets/aboutus.svg',
              height: 22,
              width: 22,
            ),
            title: const Text(
              "About Us",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          const Spacer(),
          ListTile(
            onTap: () {},
            leading: SvgPicture.asset(
              'assets/settings.svg',
              height: 22,
              width: 22,
            ),
            title: const Text(
              "Settings",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            onTap: () {
              _logoutnow();
            },
            leading: const Icon(
              Icons.logout,
              size: 28.0,
              color: Colors.black,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ]),
      ),
    );
  }
}
