import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/details_state.dart';
import 'OrderPageSecond.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _form = GlobalKey<FormState>();

  String? _fullName;
  String? _phone;
  String? _email;
  String? _address;
  String? _city;
  String? _zipCode;
  String? _organizationName;
  String? _vatNo;
  // String? _orderId;
  // String? _orderRequirement;
  // String? _file;
  // String? _budget;
  void _nextButton() async {
    var isValid = _form.currentState?.validate();

    if (!isValid!) {
      //if not valid / if empty)
      return;
    }
    _form.currentState?.save();
    print("_fullName: $_fullName");
    print("_phone: $_phone");
    print("_email: $_email");
    print("_address: $_address");
    print("_city: $_city");
    print("_vat: $_vatNo");
    print("_organizationName: $_organizationName");
    print("_zipCode: $_zipCode");

    context.read<DetailsState>().OrderData(_fullName, _phone, _email, _city,
        _address, _zipCode, _organizationName, _vatNo);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OrderPageSecond()));
  }

  // if (isOrdered) {
  //   // print('hospitalName: $_hospitalName');
  //   // print('doctorname: $_doctorName');
  //   // print('_imageData: $_imageData');
  //   // print('doctorname: $formattedDate');
  //   // print('formattedDate: $_fullName');
  //   // print('_email: $_email');
  //   // print('_phone: $_phone');
  //   // print('_address: $_address');
  //   // context.read<DetailsState>().PatientName(_fullName);
  //   // context.read<DetailsState>().AppointmentDate(formattedDate);
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => const OrderInvoice()));

  //   // Navigator.of(context).pushReplacementNamed(const HomeScreen().routeName);
  // } else {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text(
  //             "Please fill all the required fields.",
  //           ),
  //           actions: [
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text(
  //                 "Ok",
  //                 style: TextStyle(
  //                   fontSize: 18.0,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    var title = Provider.of<DetailsState>(context, listen: false)
        .titleServices
        .toString();
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

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
          title,
          style: const TextStyle(color: Colors.black, fontSize: 22.0),
        ),
        elevation: 0.2,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Place your order here",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 10),
                Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      TextFormField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter your full name';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          _fullName = v;
                        },
                        cursorHeight: 22,
                        decoration: const InputDecoration(
                            // prefixIcon: Icon(
                            //   Icons.person,
                            //   color: Colors.black,
                            // ),
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.all(
                            //     Radius.circular(12.0),
                            //   ),
                            // ),
                            labelText: 'Full name *',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 209, 209, 209),
                            )),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter your phone number';
                          }
                          if (v.length < 10) {
                            return "Phone number is less than 10 digits";
                          }
                          if (v.length > 10) {
                            return "Phone number is more than 10 digits";
                          }
                          return null;
                        },
                        onSaved: (v) {
                          _phone = v;
                        },
                        cursorHeight: 22,
                        decoration: const InputDecoration(
                            labelText: 'Phone number *',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 209, 209, 209),
                            )),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter your email address';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          _email = v;
                        },
                        cursorHeight: 22,
                        decoration: const InputDecoration(
                            labelText: 'Email *',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 209, 209, 209),
                            )),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter your city name';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          _city = v;
                        },
                        cursorHeight: 22,
                        decoration: const InputDecoration(
                            labelText: 'City *',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 209, 209, 209),
                            )),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter your address line ';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          _address = v;
                        },
                        cursorHeight: 22,
                        decoration: const InputDecoration(
                            labelText: 'Address line *',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 209, 209, 209),
                            )),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        // validator: (v) {
                        //   if (v!.isEmpty) {
                        //     return 'Enter your zip code';
                        //   }
                        //   return null;
                        // },
                        onSaved: (v) {
                          _zipCode = v;
                        },
                        cursorHeight: 22,
                        decoration: const InputDecoration(
                            labelText: 'Zip code',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 209, 209, 209),
                            )),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        // validator: (v) {
                        //   if (v!.isEmpty) {
                        //     return 'Enter your organization name';
                        //   }
                        //   return null;
                        // },
                        onSaved: (v) {
                          _organizationName = v;
                        },
                        cursorHeight: 22,
                        decoration: const InputDecoration(
                            labelText: 'Organization name',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 209, 209, 209),
                            )),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        // validator: (v) {
                        //   if (v!.isEmpty) {
                        //     return 'Enter your VAT/PN No.';
                        //   }
                        //   return null;
                        // },
                        onSaved: (v) {
                          _vatNo = v;
                        },
                        cursorHeight: 22,
                        decoration: const InputDecoration(
                            labelText: 'VAT/PAN No.',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 209, 209, 209),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        height: 50,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              padding: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
            ),
            onPressed: () {
              _nextButton();
            },
            child: const Text(
              'Next',
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
