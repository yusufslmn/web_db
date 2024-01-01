class Attributes {
  String? name;
  List<Items>? items;

  Attributes({this.name, this.items});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    if (json['items'] != null) {
      final List<dynamic> list = json['items'] as List<dynamic>;
      items = list.map((v) {
        if (v != null) v as Map<String, dynamic>;
        return Items.fromJson(v);
      }).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  String? name;

  Items({this.id, this.name});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
