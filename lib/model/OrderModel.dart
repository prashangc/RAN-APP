class OrderModel {
  int? id;
  String? fullName;
  String? phone;
  String? email;
  String? address;
  String? city;
  String? zipCode;
  String? organizationName;
  String? vat;
  String? orderID;
  String? orderRequirement;
  String? file;
  String? budget;

  OrderModel({
    this.id,
    this.fullName,
    this.phone,
    this.email,
    this.address,
    this.city,
    this.zipCode,
    this.organizationName,
    this.vat,
    this.orderID,
    this.orderRequirement,
    this.file,
    this.budget,
  });
  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    fullName = json['fullName']?.toString();
    phone = json['phone']?.toString();
    email = json['email']?.toString();
    address = json['address']?.toString();
    city = json['city']?.toString();
    zipCode = json['zipCode']?.toString();
    organizationName = json['organizationName']?.toString();
    vat = json['vat']?.toString();
    orderID = json['orderID']?.toString();
    orderRequirement = json['orderRequirement']?.toString();
    file = json['file']?.toString();
    budget = json['budget']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['city'] = city;
    data['zipCode'] = zipCode;
    data['organizationName'] = organizationName;
    data['vat'] = vat;
    data['orderID'] = orderID;
    data['orderRequirement'] = orderRequirement;
    data['file'] = file;
    data['budget'] = budget;
    return data;
  }
}
