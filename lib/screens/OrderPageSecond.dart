import 'package:app/screens/OrderInvoice.dart';
import 'package:app/state/details_state.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class OrderPageSecond extends StatefulWidget {
  // const OrderPageSecond({Key? key}) : super(key: key);

  @override
  State<OrderPageSecond> createState() => _OrderPageSecondState();
}

class _OrderPageSecondState extends State<OrderPageSecond> {
  FilePickerResult? result;
  File? saveFile;
  File? image;
  PlatformFile? file;
  // File? finalFile;
  List<PlatformFile>? files;
  final _form = GlobalKey<FormState>();

  String? _orderId;
  String? _orderRequirement;
  String? _budget;
  String baseUrl = 'http://10.0.2.2:8000/';

  var title, fullName, phone, email, city, address, zip, organizationName, vat;
  // void _uploadFiles() async {

  // }

  // void _testPost() async {
  //   await Provider.of<DetailsState>(context, listen: false).postOrderFile(
  //     image!,
  //   );
  // }

  void _orderService() async {
    var isValid = _form.currentState?.validate();

    if (!isValid!) {
      //if not valid / if empty)
      return;
    }
    _form.currentState?.save();
    // print("_orderId: $_orderId");
    // print("vat: $vat");
    // bool isFile =
    //     await Provider.of<DetailsState>(context, listen: false).postOrderFile(
    //   saveFile!,
    // );

    // print('finalFile::::${finalFile!.path.toString()}');

    bool isOrdered = await Provider.of<DetailsState>(context, listen: false)
        .postOrders(
            fullName.toString(),
            email.toString(),
            phone.toString(),
            address.toString(),
            city.toString(),
            zip.toString(),
            organizationName.toString(),
            vat.toString(),
            _orderId.toString(),
            _orderRequirement.toString(),
            _budget.toString(),
            image!);

    if (isOrdered) {
      context.read<DetailsState>().OrderID(_orderId, _budget);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OrderInvoice()));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Enter valid details ",
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    title = Provider.of<DetailsState>(context, listen: false)
        .titleServices
        .toString();

    fullName =
        Provider.of<DetailsState>(context, listen: false).full_name.toString();
    phone = Provider.of<DetailsState>(context, listen: false)
        .phone_number
        .toString();
    email = Provider.of<DetailsState>(context, listen: false).email.toString();
    city = Provider.of<DetailsState>(context, listen: false).city.toString();

    address =
        Provider.of<DetailsState>(context, listen: false).address.toString();
    zip = Provider.of<DetailsState>(context, listen: false).zip.toString();

    organizationName = Provider.of<DetailsState>(context, listen: false)
        .organization_name
        .toString();
    vat = Provider.of<DetailsState>(context, listen: false).vat.toString();

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
        title: const Text(
          "title",
          style: TextStyle(color: Colors.black, fontSize: 22.0),
        ),
        elevation: 0.2,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            return 'Enter order ID';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          _orderId = v;
                        },
                        cursorHeight: 22,
                        decoration: const InputDecoration(
                            labelText: 'Order ID',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 209, 209, 209),
                            )),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter order requirement';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          _orderRequirement = v;
                        },
                        cursorHeight: 22,
                        decoration: const InputDecoration(
                            labelText: 'Order requirement *',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromRGBO(209, 209, 209, 1),
                            )),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        // validator: (v) {
                        //   if (v!.isEmpty) {
                        //     return 'Enter budget';
                        //   }
                        //   return null;
                        // },
                        onSaved: (v) {
                          _budget = v;
                        },
                        cursorHeight: 22,
                        decoration: const InputDecoration(
                            labelText: 'Budget',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 209, 209, 209),
                            )),
                      ),
                      const SizedBox(height: 25.0),
                      DottedBorder(
                        dashPattern: const [8, 10],
                        strokeWidth: 1.5,
                        strokeCap: StrokeCap.round,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(5),
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          width: width,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.solidFolderOpen,
                                size: 45,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Upload files or attachments',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: width * 0.3,
                                height: 40,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    padding: const EdgeInsets.all(8.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ),
                                  onPressed: () async {
                                    result = await FilePicker.platform
                                        .pickFiles(
                                            allowMultiple: true,
                                            type: FileType.custom,
                                            allowedExtensions: [
                                          'jpg',
                                          'png',
                                          'mp4',
                                          'pdf',
                                          'doc',
                                          'docx',
                                        ]);
                                    print('result:::$result');
                                    if (result == null) {
                                      return showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                "No files were selected",
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.black,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                  ),
                                                  child: const Text(
                                                    "Ok",
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    }

                                    // final File? saveFile = File(result!.files[i]);
                                    file = result!.files.first;
                                    final File saveFile =
                                        File(file!.path.toString());

                                    setState(() {
                                      image = saveFile;
                                      // Navigator.pop(context);
                                    });
                                    print(
                                        'image:::::::::::::::::::::::    $image');
                                    print(
                                        "saveFile Path......${saveFile.path.toString()}");
                                    print(
                                        "saveFile ......${saveFile.toString()}");

                                    // uploadFile() async {
                                    //   var postUri =
                                    //       Uri.parse("${baseUrl}api/Order/");
                                    //   var request = http.MultipartRequest(
                                    //       "POST", postUri);
                                    //   request.fields['file'] = 'file';
                                    //   request.files.add(
                                    //       http.MultipartFile.fromBytes(
                                    //           'file',
                                    //           await File.fromUri(Uri.parse(
                                    //                   saveFile.toString()))
                                    //               .readAsBytes(),
                                    //           contentType: MediaType(
                                    //             'image',
                                    //             'jpeg',
                                    //           )));

                                    //   request.send().then((response) {
                                    //     if (response.statusCode == 200) {
                                    //       print("Uploaded!");
                                    //     }
                                    //   });
                                    // }

                                    // var uri = Uri.parse('${baseUrl}api/Order/');
                                    // var request =
                                    //     http.MultipartRequest('POST', uri);
                                    // request.files.add(
                                    //     await http.MultipartFile.fromPath(
                                    //         'file', saveFile.toString()));
                                    // var response = await request.send();
                                    // if (response.statusCode == 200) {
                                    //   print('Upload: ');
                                    // } else {
                                    //   print('Something went wrong');
                                    // }
                                  },
                                  child: const Text(
                                    'Browse',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      (file == null)
                          ? Container()
                          : Container(
                              height: 190,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: ListView.builder(
                                  // physics: const NeverScrollableScrollPhysics(),
                                  itemCount: result!.files.length,
                                  itemBuilder: (ctx, i) {
                                    final file = result!.files[i];

                                    // final finalFile =
                                    //     File(file.path.toString());
                                    return buildFile(file);
                                  }),
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
        margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 12.0),
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
              // print('fullName: $fullName');
              // print('email: $email');
              // print('phone: $phone');
              // print('_orderID: $_orderId');
              // print("files......${file!.path.toString()}");

              // var serviceTitle = title.data;
              // context.read<DetailsState>().ServiceTitle(serviceTitle);
              _orderService();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const OrderInvoice()));
            },
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void viewFile(PlatformFile file) {
    OpenFile.open(file.path);
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1000;
    final mb = kb / 1000;

    final fileSize = mb >= 1 ? mb.toStringAsFixed(2) : kb.toStringAsFixed(2);
    final extension = file.extension ?? 'none';
    // final color = getColor(extension);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 247, 245, 245),
        ),
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            OpenFile.open(file.path);
          },
          child: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Image.asset(
                    file.extension == "jpg"
                        ? 'assets/jpgIconSolid.png'
                        : file.extension == "mp4"
                            ? 'assets/mp3IconSolid.png'
                            : file.extension == "pdf"
                                ? 'assets/pdfIconsSolid.png'
                                : file.extension == "png"
                                    ? 'assets/pngIconsSolid.png'
                                    : file.extension == "doc"
                                        ? 'assets/docIcons.png'
                                        : file.extension == "docx"
                                            ? 'assets/docIcons.png'
                                            : 'assets/user.png',
                    width: 35,
                  )),
              Expanded(
                child: ListTile(
                  title: Text(
                    file.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  subtitle: Row(
                    children: [
                      const Text(
                        "Size: ",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        fileSize.toString(),
                        style: const TextStyle(fontSize: 10),
                      ),
                      const SizedBox(width: 3.0),
                      Text(
                        file.size <= 1000000 ? "KB" : "MB",
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  trailing: Image.asset(
                    'assets/crossMark.png',
                    width: 20,
                    color: const Color.fromARGB(255, 180, 178, 178),
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
