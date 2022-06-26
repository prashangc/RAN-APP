import 'package:app/GridContainer/gridServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../screens/MyOrders.dart';
import '../state/details_state.dart';

class AllServicesList extends StatefulWidget {
  static const routeName = "/AllServicesList-screen";
  const AllServicesList({Key? key}) : super(key: key);

  @override
  State<AllServicesList> createState() => _AllServicesListState();
}

class _AllServicesListState extends State<AllServicesList> {
  bool _init = true;
  bool _isLoading = false;

  var size, height, width;
  @override
  void didChangeDependencies() async {
    if (_init) {
      // _isLoading = await Provider.of<DetailsState>(context, listen: false)
      //     .getAllServiceTitles();
      _isLoading = await Provider.of<DetailsState>(context, listen: false)
          .getAllServiceTitles();

      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final serviceLists = Provider.of<DetailsState>(context).serviceTitle;
    // final serviceLists = Provider.of<DetailsState>(context).TESTserviceTitle;

    height = size.height;
    width = size.width;
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appBar(context),
            SingleChildScrollView(
              child: Container(
                color: Colors.grey[200],
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 5),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 5),
                      width: width,
                      // height: height,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        // border: Border.all(
                        //   color: const Color.fromARGB(255, 224, 223, 223),
                        // ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                          itemCount: serviceLists!.length,
                          itemBuilder: (context, index) {
                            return GridServices(serviceLists[index]);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _appBar(BuildContext context) {
  return Container(
    decoration: const ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
    ),
    width: MediaQuery.of(context).size.width,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 20),
              const Expanded(
                child: Text(
                  "Services",
                  style: TextStyle(fontSize: 22.0, color: Colors.black),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 42,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.add_business,
                    color: Colors.white,
                    size: 16.0,
                  ),
                  label: const Text(
                    'My Orders',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyOrders()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    ),
  );
}
