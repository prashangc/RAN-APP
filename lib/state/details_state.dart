import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'package:app/model/MembersModel.dart';
import 'package:app/model/OrderModel.dart';
import 'package:app/model/ProgramModel.dart';
import 'package:app/model/ImageSliderModel.dart';
import 'package:app/model/ServicesModel.dart';
import 'package:app/model/StatsModel.dart';
import 'package:app/model/TESTFORSERVICE.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../model/ProjectsModel.dart';
import '../model/YearModel.dart';

class DetailsState with ChangeNotifier {
  LocalStorage storage = LocalStorage("usertoken");
  List<ServicesModel>? _services;
  List<TESTFORSERVICE>? _testServices;

  List<ProjectsModel>? _projects;
  List<ProgramsModel>? _programs;

  List<ImageSliderModel>? _imageSlider;
  List<MembersModel>? _members;
  List<YearModel>? _years;
  List<OrderModel>? _orders;

  List<StatsModel>? _statsDetails;
  // String baseUrl = 'http://10.0.2.2:8000/';
  // static String baseUrl = 'http://mobileapplication.ran.org.np/';
  // String baseUrl = 'http://192.168.1.88:8000/';

  static String baseUrl = 'http://192.168.1.76:8000/';

  List? data;
  List imagesUrl = [];

  var titleServices,
      imageServices,
      full_name,
      phone_number,
      email,
      city,
      Budget,
      address,
      zip,
      organization_name,
      vat,
      order_id;

  Future<List> getImageSliderData() async {
    try {
      String url = '${baseUrl}api/images/';
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error('Server error');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List> getAllScreenTitles() async {
    try {
      String url = '${baseUrl}api/titles/';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error('Server error');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> getAllServiceTitles() async {
    try {
      String url = '${baseUrl}Services/';
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "token f5f49f7acc36c89441899028e49f3fa71c365860",
        },
      );
      var data = json.decode(response.body) as List;
      List<ServicesModel> temp = [];
      for (var element in data) {
        ServicesModel services = ServicesModel.fromJson(element);
        temp.add(services);
      }
      _services = temp;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getTestServiceTitles() async {
    try {
      String url = '${baseUrl}api/services/';
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );
      var data = json.decode(response.body) as List;
      List<TESTFORSERVICE> temp = [];
      for (var element in data) {
        TESTFORSERVICE testServices = TESTFORSERVICE.fromJson(element);
        temp.add(testServices);
      }
      _testServices = temp;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getAllProjectTitles() async {
    try {
      var token = storage.getItem('token');
      String url = '${baseUrl}Projects/';
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "token f5f49f7acc36c89441899028e49f3fa71c365860",
        },
      );
      var data = json.decode(response.body) as List;
      List<ProjectsModel> temp = [];
      for (var element in data) {
        ProjectsModel projects = ProjectsModel.fromJson(element);
        temp.add(projects);
      }
      _projects = temp;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<MembersModel>> searchMember(
      {required String query}) async {
    http.Response responseMember;
    List? membersDetails;
    List<MembersModel>? members;

    var url = '$baseUrl/Membership/';
    responseMember = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'token f5f49f7acc36c89441899028e49f3fa71c365860',
    });
    if (responseMember.statusCode == 200) {
      membersDetails = await Future.delayed(
          const Duration(seconds: 1), () => json.decode(responseMember.body));

      members = membersDetails!.map((e) => MembersModel.fromJson(e)).toList();

      // if (query != null) {
      //   program = program!
      //       .where((element) => element.programName!
      //           .toLowerCase()
      //           .contains((query.toLowerCase())))
      //       .toList();
      // }
    }
    return members!;
  }

  static Future<List<ProgramsModel>> searchProgram(
      {required String query}) async {
    http.Response responseProgram;
    List? programDetails;
    List<ProgramsModel>? program;
    var url = '$baseUrl/Programs/';
    responseProgram = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'token f5f49f7acc36c89441899028e49f3fa71c365860',
    });
    if (responseProgram.statusCode == 200) {
      programDetails = await Future.delayed(
          const Duration(seconds: 1), () => json.decode(responseProgram.body));

      program = programDetails!.map((e) => ProgramsModel.fromJson(e)).toList();

      // if (query != null) {
      //   program = program!
      //       .where((element) => element.programName!
      //           .toLowerCase()
      //           .contains((query.toLowerCase())))
      //       .toList();
      // }
    }
    return program!;
  }

  Future<bool> getAllProgramsTitles() async {
    try {
      String url = '${baseUrl}Programs/';
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "token f5f49f7acc36c89441899028e49f3fa71c365860",
        },
      );
      var data = json.decode(response.body) as List;
      List<ProgramsModel> temp = [];
      for (var element in data) {
        ProgramsModel programs = ProgramsModel.fromJson(element);
        temp.add(programs);
      }
      _programs = temp;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getAllStatsDetails() async {
    try {
      String url = '${baseUrl}api/stats/';
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );
      var data = json.decode(response.body) as List;
      List<StatsModel> temp = [];
      for (var element in data) {
        StatsModel stats = StatsModel.fromJson(element);
        temp.add(stats);
      }
      _statsDetails = temp;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getAllMembersDetails() async {
    try {
      String url = '${baseUrl}Membership/';
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "token f5f49f7acc36c89441899028e49f3fa71c365860",
        },
      );
      var data = json.decode(response.body) as List;
      List<MembersModel> temp = [];
      for (var element in data) {
        MembersModel members = MembersModel.fromJson(element);
        temp.add(members);
      }
      _members = temp;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getAllYearsDetails() async {
    try {
      String url = '${baseUrl}Tenures/';
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "token f5f49f7acc36c89441899028e49f3fa71c365860",
        },
      );
      var data = json.decode(response.body) as List;
      List<YearModel> temp = [];
      for (var element in data) {
        YearModel years = YearModel.fromJson(element);
        temp.add(years);
      }
      _years = temp;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> loginNow(String username, String password) async {
    try {
      String url = '${baseUrl}login/';
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({
            'username': username,
            'password': password,
          }));
      var data = json.decode(response.body) as Map;
      // print(data);
      if (data.containsKey('token')) {
        // print(data['token']);
        storage.setItem('token', data['token']);
        // print(storage.getItem('token'));
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      print("error loginNow");
      return true;
    }
  }

  Future<bool> registerNow(String username, String email, String password,
      String confirmPassword) async {
    try {
      String url = '${baseUrl}register/';
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "username": username,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        }),
      );
      var data = json.decode(response.body) as Map;

      return data['error'];
    } catch (e) {
      print("error register");
      print(e);
      return true;
    }
  }

  Future<bool> getOrdersDetails() async {
    try {
      String url = '${baseUrl}api/Order/';
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );
      var data = json.decode(response.body) as List;
      List<OrderModel> temp = [];
      for (var element in data) {
        OrderModel order = OrderModel.fromJson(element);
        temp.add(order);
      }
      _orders = temp;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> postOrders(
    String _fullName,
    String _email,
    String _phone,
    String _address,
    String _city,
    String _zipCode,
    String _organizationName,
    String _vatNo,
    String _orderId,
    String _orderRequirement,
    // String _file,
    String _budget,
    File file,
  ) async {
    Uri url = Uri.parse('http://192.168.1.78:8000/api/Order/');

    try {
      print('fullName  $_fullName');
      print('email  $_email');
      print('phone  $_phone');
      print('address  $_address');
      print('_city  $_city');
      print('_zipCode  $_zipCode');
      print('_organizationName  $_organizationName');
      print('_vatNo  $_vatNo');
      print('_orderId  $_orderId');
      print('_orderRequirement  $_orderRequirement');
      print('file  $file');

      var stream1 = http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length1 = await file.length();
      var request = http.MultipartRequest("POST", url);
      // request.headers["authorization"] = 'Token $token';
      request.fields["fullName"] = _fullName;
      request.fields["phone"] = _phone;
      request.fields["email"] = _email;
      request.fields["address"] = _address;
      request.fields["city"] = _city;
      request.fields["zipCode"] = _zipCode;
      request.fields["organizationName"] = _organizationName;
      request.fields["vat"] = _vatNo;
      request.fields["orderID"] = _orderId;
      request.fields["orderRequirement"] = _orderRequirement;
      request.fields["budget"] = _budget;
      var multipartFile1 = http.MultipartFile('file', stream1, length1,
          filename: basename(file.path));
      request.files.add(multipartFile1);
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> postOrderFile(
    File photo1,
  ) async {
    Uri url = Uri.parse('${baseUrl}api/test/');
    try {
      var stream1 = http.ByteStream(DelegatingStream.typed(photo1.openRead()));
      var length1 = await photo1.length();
      var request = http.MultipartRequest("POST", url);
      // request.headers["authorization"] = 'Token $token';
      var multipartFile1 = http.MultipartFile('file', stream1, length1,
          filename: basename(photo1.path));
      request.files.add(multipartFile1);
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      print(respStr);
      print('status code: ${response.statusCode}');
      return true;
    } catch (err) {
      print('errore message= $err');
      rethrow;
    }
  }

  List<ImageSliderModel>? get imageSlider {
    return [...?_imageSlider];
  }

  List<ServicesModel>? get serviceTitle {
    return [...?_services];
  }

  List<TESTFORSERVICE>? get TESTserviceTitle {
    return [...?_testServices];
  }

  List<ProjectsModel>? get projectTitle {
    return [...?_projects];
  }

  List<ProgramsModel>? get programTitle {
    return [...?_programs];
  }

  List<StatsModel>? get statsDetails {
    return [...?_statsDetails];
  }

  List<MembersModel>? get membersDetails {
    return [...?_members];
  }

  List<YearModel>? get yearDetails {
    return [...?_years];
  }

  List<OrderModel>? get orderDetails {
    return [...?_orders];
  }

  MembersModel? singlePost(int membershipID) {
    return _members
        ?.firstWhere((element) => element.membershipID == membershipID);
  }

  YearModel? yearsData(int yearID) {
    return _years?.firstWhere((element) => element.id == yearID);
  }

  ProjectsModel? projectsData(int projectID) {
    return _projects?.firstWhere((element) => element.projectID == projectID);
  }

  ServicesModel? servicesData(int servicesID) {
    return _services?.firstWhere((element) => element.servicesID == servicesID);
  }

  TESTFORSERVICE? TESTservicesData(int servicesID) {
    return _testServices?.firstWhere((element) => element.id == servicesID);
  }

  ProgramsModel? programsData(int programID) {
    return _programs?.firstWhere((element) => element.programID == programID);
  }

  OrderModel? ordersData(int orderID) {
    return _orders?.firstWhere((element) => element.id == orderID);
  }

  void ServiceTitle(var title) {
    titleServices = title;
  }

  void ServiceImage(var image) {
    imageServices = image;
  }

  void OrderID(var orderID, var budget) {
    order_id = orderID;
    Budget = budget;
  }

  void OrderData(var fullName, var phoneNumber, var Email, var City,
      var Address, var Zip, var organizationName, var Vat) {
    full_name = fullName;
    phone_number = phoneNumber;
    email = Email;
    city = City;
    address = Address;
    zip = Zip;
    organization_name = organizationName;
    vat = Vat;
  }
}
