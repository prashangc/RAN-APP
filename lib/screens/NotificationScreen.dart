import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  // static const routeName = "/Notification-screen";
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
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
          'Notifications',
          style: TextStyle(color: Colors.black, fontSize: 22.0),
        ),
        elevation: 0.2,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Navigator.of(context).pushNamed(FavouriteHospitals.routeName,
              // arguments: hospitalLists);
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (ctx, i) {
                return Container(
                  color: Colors.red,
                );
              })),
    );
  }
}
