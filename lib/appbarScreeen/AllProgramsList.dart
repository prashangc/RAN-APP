import 'package:app/model/ProgramModel.dart';
import 'package:app/screens/ProgramDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../GridContainer/gridPrograms.dart';
import '../state/details_state.dart';

class AllProgramsList extends StatefulWidget {
  const AllProgramsList({Key? key}) : super(key: key);
  // final ProgramsModel programs;
  // const AllProgramsList(this.programs);
  @override
  State<AllProgramsList> createState() => _AllProgramsListState();
}

class _AllProgramsListState extends State<AllProgramsList> {
  bool _switch = false;
  bool _iconSwitch = false;
  bool _init = true;
  bool _isLoading = false;
  var size, height, width;
  @override
  void didChangeDependencies() async {
    if (_init) {
      _isLoading = await Provider.of<DetailsState>(context, listen: false)
          .getAllProgramsTitles();
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final programsLists = Provider.of<DetailsState>(context).programTitle;

    height = height;
    width = width;
    size = MediaQuery.of(context).size;
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
        title: const Text(
          'Programs',
          style: TextStyle(color: Colors.black, fontSize: 22.0),
        ),
        elevation: 0.2,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // if (_switch = false) {
              //   setState(() {
              //     _switch = true;
              //   });
              // }
              // _switch = false;

              setState(() {
                _switch = !_switch;
                _iconSwitch = !_iconSwitch;
              });
            },
            icon: Icon(
              _iconSwitch ? Icons.grid_on : Icons.view_list,
              size: 25,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: width,
        height: height,
        // color: Colors.red[200],
        child: _switch
            ? ListColumn(context, programsLists)
            : GridColumn(programsLists),
      ),
    );
  }
}

Widget GridColumn(List<ProgramsModel>? project) {
  List<ProgramsModel>? projects = project;
  return Container(
    margin: const EdgeInsets.all(13),
    // width: width,
    // height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      // border: Border.all(
      //   color: const Color.fromARGB(255, 224, 223, 223),
      // ),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: StaggeredGridView.countBuilder(
        staggeredTileBuilder: (index) {
          return const StaggeredTile.count(1, 1.3);
        },
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 20.0,
        padding: const EdgeInsets.only(top: 7),
        crossAxisSpacing: 20.0,
        itemCount: projects!.length,
        itemBuilder: (context, index) {
          return GridPrograms(projects[index]);
        },
      ),
    ),
  );
}

Widget ListColumn(BuildContext context, List<ProgramsModel>? project) {
  return ListView.builder(
      itemCount: project!.length,
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
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                        project[i].programCoverImage.toString(),
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
                  project[i].programName.toString(),
                  maxLines: 6,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 14, top: 8.0),
                child: Text(
                  project[i].objectives.toString(),
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
                              arguments: project[i].programID);

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
      });
}
