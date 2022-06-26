import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../state/details_state.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  bool _init = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_init) {
      _isLoading = await Provider.of<DetailsState>(context, listen: false)
          .getOrdersDetails();
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
          "My Orders",
          style: TextStyle(color: Colors.black, fontSize: 22.0),
        ),
        elevation: 0.2,
      ),
      body: AllOrderList(context),
    );
  }

  Widget AllOrderList(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final ordersList = Provider.of<DetailsState>(context).orderDetails;
    if (ordersList == null || _isLoading == false ) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No data found",
            style: TextStyle(color: Colors.red),
          ),
          //  CircularProgressIndicator()
        ),
      );
    }
    return ListView.builder(
        itemCount: ordersList.length,
        itemBuilder: (ctx, i) {
          final data = ordersList[i];

          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // color: Colors.yellow,
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
                          fit: BoxFit.fill,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 199, 199, 199),
                            blurRadius: 3,
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        // border: Border.all(
                        //   color: const Color.fromARGB(255, 224, 223, 223),
                        // ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              // '${widget.hospitalsData.hospitalDetail.toString().substring(0, 200)}...',

                              'Service',
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 3.0),
                            Row(
                              children: [
                                const Text("Order ID:"),
                                const SizedBox(width: 4),
                                Text(
                                  data.orderID.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              children: const [
                                Text(
                                  "2022-03-31",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "12:45 PM",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    color: const Color.fromARGB(
                                        255, 248, 218, 255),
                                    padding: const EdgeInsets.all(8),
                                    child: const Text(
                                      'SUBMITTED',
                                      style: TextStyle(
                                          color: Colors.purple, fontSize: 11.0),
                                    )),
                                const SizedBox(width: 10.0),
                                Container(
                                    color: const Color.fromARGB(
                                        255, 252, 218, 218),
                                    padding: const EdgeInsets.all(8),
                                    child: const Text('UNPAID',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 11.0)))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Icon(
                      FontAwesomeIcons.trashAlt,
                      size: 25,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              width: width,
              height: height / 6,
            ),
          );
        });
  }
}
