import 'package:app/model/ProgramModel.dart';
import 'package:app/screens/NotificationScreen.dart';

import 'package:app/widgets/Projects.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../appbarScreeen/AllProgramsList.dart';
import '../appbarScreeen/AllProjectsList.dart';
import '../appbarScreeen/AllServicesList.dart';
import '../state/details_state.dart';
import '../widgets/Programs.dart';
import '../widgets/Services.dart';
import '../widgets/Stats.dart';

class HomeBottomNavigation extends StatefulWidget {
  const HomeBottomNavigation({Key? key}) : super(key: key);

  @override
  State<HomeBottomNavigation> createState() => _HomeBottomNavigationState();
}

class _HomeBottomNavigationState extends State<HomeBottomNavigation> {
  Future<ProgramsModel>? programsDetails;
  bool _init = true;
  bool _isLoading = false;
  var size, height, width;
  @override
  void didChangeDependencies() async {
    if (_init) {
      _isLoading = await Provider.of<DetailsState>(context, listen: false)
          .getAllServiceTitles();
      _isLoading = await Provider.of<DetailsState>(context, listen: false)
          .getAllProjectTitles();
      _isLoading = await Provider.of<DetailsState>(context, listen: false)
          .getAllProgramsTitles();
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getData();
  // }

  // getData() async {
  //   programsDetails = await getAllProgramsTitles();
  //   setState(() {});
  // }

  // final services = List.generate(6, (index) => '$index');
  int activeIndex = 0;
  DetailsState imageAPIData = DetailsState();
  // DetailsState servicesAPIData = DetailsState();

  late List data;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final servicesLists = Provider.of<DetailsState>(context).serviceTitle;
    // final servicesLists = Provider.of<DetailsState>(context).TESTserviceTitle;
    final projectsLists = Provider.of<DetailsState>(context).projectTitle;
    final programsLists = Provider.of<DetailsState>(context).programTitle;
    final statsLists = Provider.of<DetailsState>(context).statsDetails;
    // if (_isLoading == false) {
    //   return const Scaffold(
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 80.0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()),
                );
              },
              icon: const Icon(FontAwesomeIcons.bell),
              color: Colors.black,
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    // letterSpacing: 0.5,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                "Good Morning!",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    // letterSpacing: 0.5,
                    color: Colors.black,
                  ),
                ),
                // TextStyle(
                //   fontSize: 25.0,
                //   letterSpacing: 1.0,
                //   color: Colors.black,
                // ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                // FutureBuilder<List>(
                //   future: imageAPIData.getImageSliderData(),
                //   builder: (context, snapshot) {
                //     // print(snapshot.data);
                //     var actualImages = snapshot.data;
                //     if (actualImages!.isNotEmpty) {
                //       return Stack(
                //         children: [
                //           CarouselSlider.builder(
                //             options: CarouselOptions(
                //                 height: 220.0,
                //                 // enlargeCenterPage: true,
                //                 autoPlay: true,
                //                 aspectRatio: 16 / 9,
                //                 autoPlayCurve: Curves.fastOutSlowIn,
                //                 enableInfiniteScroll: true,
                //                 autoPlayAnimationDuration:
                //                     const Duration(milliseconds: 800),
                //                 viewportFraction: 1,
                //                 onPageChanged: (index, reason) {
                //                   setState(() {
                //                     activeIndex = index;
                //                   });
                //                 }),
                //             itemCount: actualImages.length,
                //             itemBuilder: (context, index, realIndex) {
                //               return Container(
                //                 decoration: BoxDecoration(
                //                   image: DecorationImage(
                //                     image: NetworkImage(
                //                       actualImages[index]['pictures']
                //                           .toString(),
                //                     ),
                //                     fit: BoxFit.fill,
                //                   ),
                //                   borderRadius: const BorderRadius.all(
                //                       Radius.circular(20.0)),
                //                 ),
                //               );
                //             },
                //           ),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.only(top: 195.0),
                //                 child: AnimatedSmoothIndicator(
                //                   activeIndex: activeIndex,
                //                   count: snapshot.data!.length,
                //                   effect: const ExpandingDotsEffect(
                //                     activeDotColor: Colors.indigo,
                //                     dotColor: Colors.grey,
                //                     dotWidth: 14.0,
                //                     dotHeight: 14.0,
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       );
                //     } else {
                //       return const Center(
                //         child: Text(
                //           'No Images found for image slider',
                //         ),
                //       );
                //     }
                //   },
                // ),
                // const SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                  child: Container(
                    width: width,
                    // height: 160.0,
                    height: height * 0.28,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
                          child: Text(
                            'Top Services',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                letterSpacing: 0.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: servicesLists!.length,
                                itemBuilder: (ctx, i) {
                                  if (servicesLists.isEmpty) {
                                    const Text(
                                      "Services data not found",
                                      style: TextStyle(color: Colors.red),
                                    );
                                  }
                                  return Services(servicesLists[i]);
                                }),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              padding: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AllServicesList()),
                              );
                            },
                            child: const Text(
                              'View more',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                  child: Container(
                    width: double.infinity,
                    // height: 160.0,
                    height: height * 0.28,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 0.0),
                          child: Text(
                            'Top Projects',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                letterSpacing: 0.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: projectsLists!.length,
                                itemBuilder: (ctx, i) {
                                  if (projectsLists.isEmpty) {
                                    const Text("Projects data not found");
                                  }
                                  return Projects(projectsLists[i]);
                                }),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              padding: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AllProjectsList()),
                              );
                            },
                            child: const Text(
                              'View more',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                  child: Container(
                    width: double.infinity,
                    // height: 160.0,
                    height: height * 0.28,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 0.0),
                          child: Text(
                            'Top Programs',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                letterSpacing: 0.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: programsLists!.length,
                                itemBuilder: (ctx, i) {
                                  if (programsLists.isEmpty) {
                                    const Text("programsLists data not found");
                                  }
                                  return Programs(programsLists[i]);
                                }),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              padding: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AllProgramsList()),
                              );
                            },
                            child: const Text(
                              'View more',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                  child: Container(
                    width: width,
                    height: height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 0.0),
                          child: Text(
                            'Stats',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                letterSpacing: 0.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // scrollDirection: Axis.horizontal,
                                itemCount: statsLists!.length,
                                itemBuilder: (ctx, i) {
                                  if (statsLists.isEmpty) {
                                    const Text("no stats data");
                                  }
                                  return Stats(statsLists[i]);
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget buildGridView() {
  //   return Container(
  //       // color: Colors.red,
  //       child: FutureBuilder<List>(
  //           future: servicesAPIData.getAllServiceTitles(),
  //           builder: (context, snapshot) {
  //             if (snapshot.hasData) {
  //               var actualGrid = snapshot.data!;
  //               return GridView.builder(
  //                   physics: const NeverScrollableScrollPhysics(),
  //                   shrinkWrap: true,
  //                   gridDelegate:
  //                       const SliverGridDelegateWithFixedCrossAxisCount(
  //                     childAspectRatio: (80.0 / 60.0),
  //                     // childAspectRatio: MediaQuery.of(context).size.width /
  //                     //     (MediaQuery.of(context).size.height / 6),

  //                     crossAxisCount: 2,
  //                     mainAxisSpacing: 10.0,
  //                     crossAxisSpacing: 10.0,
  //                   ),
  //                   padding: const EdgeInsets.all(8.0),
  //                   itemCount: actualGrid.length,
  //                   itemBuilder: (context, index) {
  //                     return Container(
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(15.0),
  //                         color: Colors.white,
  //                       ),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           const Icon(Icons.ac_unit, size: 50.0),
  //                           const SizedBox(height: 10.0),
  //                           Text(
  //                             snapshot.data![index]['title'].toString(),
  //                             style: const TextStyle(
  //                               fontSize: 20.0,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   });
  //             } else {
  //               return const Center(
  //                 child: Text(
  //                   'No data found',
  //                 ),
  //               );
  //             }
  //           }));
  // }

}
