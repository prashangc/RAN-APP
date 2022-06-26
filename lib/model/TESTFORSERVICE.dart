class TESTFORSERVICE {
  int? id;
  String? title;
  String? icons;

  TESTFORSERVICE({this.id, this.title, this.icons});

  TESTFORSERVICE.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    icons = json['icons'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['icons'] = icons;
    return data;
  }
}
