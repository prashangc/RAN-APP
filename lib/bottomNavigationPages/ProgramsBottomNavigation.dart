import 'package:app/model/ProgramModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../screens/ProgramDetails.dart';
import '../state/details_state.dart';

class ProgramsBottomNavigation extends StatefulWidget {
  const ProgramsBottomNavigation({Key? key}) : super(key: key);

  @override
  State<ProgramsBottomNavigation> createState() =>
      _ProgramsBottomNavigationState();
}

class _ProgramsBottomNavigationState extends State<ProgramsBottomNavigation> {
  bool _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      Provider.of<DetailsState>(context, listen: false).getAllProgramsTitles();
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final programsData = Provider.of<DetailsState>(context).programTitle;

    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return Scaffold(
      // endDrawer: AppDrawer(),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Programs",
          style: TextStyle(color: Colors.black, fontSize: 22.0),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Icon(FontAwesomeIcons.image, size: 25.0),
        ),
        elevation: 0.2,
        toolbarHeight: 60.0,
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              showSearch(context: context, delegate: ProgramSearch());
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
      body: SizedBox(
        width: width,
        height: height,
        // color: Colors.red[200],
        child: ListView.builder(
          itemCount: programsData!.length,
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
                                programsData[i].programCoverImage.toString(),
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
                          programsData[i].programName.toString(),
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
                          programsData[i].objectives.toString(),
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
                                      arguments: programsData[i].programID);

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

class ProgramSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, "");
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, ""),
      );

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width * 0.7,
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),

                padding: const EdgeInsets.symmetric(horizontal: 10),
                // color: Colors.red,
                child: ClipRRect(
                  child: Image.network(
                    "https://s2.coinmarketcap.com/static/img/coins/200x200/11502.png",
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "name",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                // overflow: TextOverflow.clip,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "name",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
                // overflow: TextOverflow.clip,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                // color: Colors.red,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(FontAwesomeIcons.facebookSquare, size: 33),
                      Icon(FontAwesomeIcons.twitter, size: 33),
                      Icon(FontAwesomeIcons.googlePlusG, size: 33),
                      Icon(FontAwesomeIcons.linkedin, size: 33),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container(
        color: Colors.black,
        child: FutureBuilder<List<ProgramsModel>>(
          future: DetailsState.searchProgram(query: query),
          builder: (context, snapshot) {
            if (query.isEmpty) return buildNoSuggestions();

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Expanded(
                    child: Container(
                        color: Colors.green,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: Colors.red,
                        ))));
              default:
                if (snapshot.hasError || snapshot.data!.isEmpty) {
                  return buildNoSuggestions();
                } else {
                  return Column(
                    children: [
                      //  Text(snapshot.data.length),
                      buildSuggestionsSuccess(snapshot.data!),
                    ],
                  );
                }
            }
          },
        ),
      );

  Widget buildNoSuggestions() => Center(
      child: Expanded(
          child: Container(
              color: Colors.yellow,
              child: const Center(
                child: Text(
                  'No tutors found!',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ))));

  Widget buildSuggestionsSuccess(List<ProgramsModel> suggestions) => Expanded(
        child: Container(
          color: Colors.grey,
          // ignore: avoid_unnecessary_containers
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // String foundCourse =
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Found " + suggestions.length.toString() + " Tutors",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                SizedBox(
                  //  color: darkBlueColor,
                  height: 450,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      print("The index are");
                      print(suggestions.length);
                      final suggestion = suggestions[index];
                      final image = suggestion.programCoverImage.toString();
                      final queryText = suggestion.programName
                          .toString()
                          .substring(0, query.length);
                      final remainingText = suggestion.programName
                          .toString()
                          .substring(query.length);

                      return Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: ListTile(
                          onTap: () {
                            // query = suggestion.name.toString();
                            // 1. Show Results
                            showResults(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => TutorDetailScreen(
                            //             key: null,
                            //             usersDetail: suggestions.toList(),
                            //             index: index)));
                            // 2. Close Search & Return Result
                            // close(context, suggestion);

                            // 3. Navigate to Result Page
                            //  Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) => ResultPage(suggestion),
                            //   ),
                            // );
                          },
                          // leading: Icon(Icons.location_city),
                          // title: Text(suggestion),
                          title: RichText(
                            text: TextSpan(
                              text: queryText,
                              style: const TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: remainingText,
                                  style: const TextStyle(
                                    color: Color(0xFFB4B4B4),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
