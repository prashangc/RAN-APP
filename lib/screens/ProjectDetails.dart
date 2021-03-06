import 'package:app/state/details_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({Key? key}) : super(key: key);
  static const routeName = "/projectsDetails-screen";

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var height = size.height;
    var width = size.width;
    final projectID = ModalRoute.of(context)?.settings.arguments;
    final projectData = Provider.of<DetailsState>(context)
        .projectsData(int.parse(projectID.toString()));
    return Scaffold(
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
        title: Text(
          projectData!.projectName.toString(),
          style: const TextStyle(color: Colors.black, fontSize: 22.0),
        ),
        elevation: 0.2,
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
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(13),
                width: width,
                height: height * 0.25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      projectData.projectIcon.toString(),
                    ),
                    fit: BoxFit.fill,
                  ),
                  color: Colors.blue,
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(13),
                padding: const EdgeInsets.symmetric(horizontal: 13),

                width: width,
                // color: Colors.pink,
                child: Text(
                  projectData.projectName.toString(),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
