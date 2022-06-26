import 'package:app/GridContainer/gridMembers.dart';
import 'package:app/model/MembersModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../state/details_state.dart';
import '../widgets/app_drawer.dart';

class RanMembersBottomNavigation extends StatefulWidget {
  const RanMembersBottomNavigation({Key? key}) : super(key: key);

  @override
  _RanMembersBottomNavigationState createState() =>
      _RanMembersBottomNavigationState();
}

class _RanMembersBottomNavigationState
    extends State<RanMembersBottomNavigation> {
  late final Key key;
  bool _init = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_init) {
      _isLoading = await Provider.of<DetailsState>(context, listen: false)
          .getAllMembersDetails();
      _isLoading = await Provider.of<DetailsState>(context, listen: false)
          .getAllYearsDetails();

      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    final membersList = Provider.of<DetailsState>(context).membersDetails;
    final yearsList = Provider.of<DetailsState>(context).yearDetails;

    // if (_isLoading == false || membersList == null || yearsList == null) {
    //   return const Scaffold(
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }

    return Scaffold(
      endDrawer: AppDrawer(),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.search,
                size: 28.0,
              ),
              onPressed: () =>
                  showSearch(context: context, delegate: SearchRANMembers()),
            ),
          ),
        ],
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Icon(FontAwesomeIcons.image, size: 25.0),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 60.0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "RAN Family",
          // style: TextStyle(color: Colors.black, fontSize: 22.0),
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 23.0,
              letterSpacing: 0.5,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        color: const Color.fromRGBO(238, 238, 238, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 48.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: yearsList!.length,
                  itemBuilder: (ctx, i) {
                    return GestureDetector(
                      onTap: () {
                        var yearDate = yearsList[i].year.toString();
                        var individualDate =
                            membersList![i].membershipYear.toString();
                        setState(() {});
                        // this.value = value;
                        print(": yearDate ::::: $yearDate");
                        print(": individualDate ::::: $individualDate");

                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const MembersPage()));
                        // Navigator.of(context).pushNamed(MembersPage.routeName,
                        //     arguments: membersList![i].membershipID);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          // color: Theme.of(context).colorScheme.secondary,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                            child: Text(
                              yearsList[i].year.toString(),
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Executive Members",
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
            const SizedBox(height: 5),
            Expanded(
              // color: Colors.yellow,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: StaggeredGridView.countBuilder(
                  staggeredTileBuilder: (index) {
                    return const StaggeredTile.count(1, 1.3);
                  },
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  itemCount: membersList!.length,
                  itemBuilder: (context, index) {
                    return GridMembers(membersList[index]);
                    // membersList[index].membershipYear.toString() ==
                    //         yearsList[index].year.toString()
                    //     ? GridMembers(membersList[index])
                    //     : Container(
                    //         color: Colors.red,
                    //         width: 100,
                    //         height: 20,
                    //       );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchRANMembers extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, "");
            } else {
              query = '';
              showSuggestions(context);
            }
          },
          icon: const Icon(Icons.clear),
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: const Icon(Icons.arrow_back),
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
        color: const Color.fromRGBO(238, 238, 238, 1),
        child: FutureBuilder<List<MembersModel>>(
          future: DetailsState.searchMember(query: query),
          builder: (context, snapshot) {
            if (query.isEmpty) return buildNoSuggestions();

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Expanded(
                    child: Container(
                        color: Colors.white,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
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

  Widget buildNoSuggestions() => const Center(
          child: Text(
        'No suggestions!',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ));
  Widget buildSuggestionsSuccess(List<MembersModel> suggestions) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "Found " + suggestions.length.toString() + " members",
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            const SizedBox(height: 4.0),
            StaggeredGridView.countBuilder(
                staggeredTileBuilder: (index) {
                  return const StaggeredTile.count(1, 1.3);
                },
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  print("The index are");
                  print(suggestions.length);
                  final suggestion = suggestions[index];
                  final image = suggestion.pic.toString();
                  final queryText =
                      suggestion.name.toString().substring(0, query.length);
                  final remainingText =
                      suggestion.name.toString().substring(query.length);
                  return GestureDetector(
                    onTap: () {
                      query = suggestion.toString();
                      showResults(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: Expanded(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(5.0),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 7.9,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    image,
                                    // widget.membersData.pic.toString(),
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                color: Colors.red,
                                // borderRadius: const BorderRadius.all(
                                //     Radius.circular(5.0)),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: RichText(
                                  text: TextSpan(
                                      text: queryText,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: remainingText,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      );
}
