import 'package:app/model/MembersModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class GridMembers extends StatefulWidget {
  final MembersModel membersData;
  const GridMembers(this.membersData);
  @override
  State<GridMembers> createState() => _GridMembersState();
}

class _GridMembersState extends State<GridMembers> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return
     GestureDetector(
      onTap: () {
        // CustomDialog(context);
        showPopUpDialogBox(
            context, widget.membersData.pic, widget.membersData.name);
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
                height: height / 7.9,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.membersData.pic.toString(),
                    ),
                    fit: BoxFit.fill,
                  ),
                  color: Colors.red,
                  // borderRadius: const BorderRadius.all(
                  //     Radius.circular(5.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  width: width,
                  color: Colors.white,
                  child: Text(
                    widget.membersData.name.toString(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        // letterSpacing: 0.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showPopUpDialogBox(BuildContext context, image, name) => showDialog( 
    context: context,
    builder: (context) {
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
                      image,
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  // overflow: TextOverflow.clip,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  name,
                  style: const TextStyle(
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
    });
