import 'package:app/state/details_state.dart';
import 'package:app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../screens/ProgramDetails.dart';

class BlogsBottomNavigation extends StatefulWidget {
  const BlogsBottomNavigation({Key? key}) : super(key: key);

  @override
  State<BlogsBottomNavigation> createState() => _BlogsBottomNavigationState();
}

class _BlogsBottomNavigationState extends State<BlogsBottomNavigation> {
  bool _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      Provider.of<DetailsState>(context, listen: false).getAllProgramsTitles();
    }
    _init = false;
    super.didChangeDependencies();
  }

  // DetailsState titleService = DetailsState();
  @override
  Widget build(BuildContext context) {
    final blogData = Provider.of<DetailsState>(context).programTitle;
    var size = MediaQuery.of(context).size;

    var height = size.height;
    var width = size.width;
    return Scaffold(
      endDrawer: AppDrawer(),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Icon(FontAwesomeIcons.image, size: 25.0),
        ),
        toolbarHeight: 60.0,
        backgroundColor: Colors.white,
        title: const Text(
          "Blogs",
          style: TextStyle(color: Colors.black, fontSize: 22.0),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Navigator.of(context).pushNamed(FavouriteHospitals.routeName,
              // arguments: hospitalLists);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body:
       SizedBox(
        width: width,
        height: height,
        // color: Colors.red[200],
        child: ListView.builder(
          itemCount: blogData!.length,
          itemBuilder: (ctx, i) {
            return Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                blogData[i].programCoverImage.toString(),
                              ),
                              fit: BoxFit.fill,
                            ),
                            color: Colors.blue,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, top: 8.0),
                        child: Text(
                          blogData[i].programName.toString(),
                          maxLines: 6,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 8.0),
                        child: Text(
                          blogData[i].objectives.toString(),
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 40.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  padding: const EdgeInsets.all(8.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      ProgramDetails.routeName,
                                      arguments: blogData[i].programID);

                                  // Navigator.push(
                                  // context,
                                  // MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         const ProgramDetails()));
                                },
                                child: const Text(
                                  'Read More',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15.0),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
