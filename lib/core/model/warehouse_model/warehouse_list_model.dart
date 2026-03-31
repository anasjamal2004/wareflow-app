class WarehouseListModel {
  String? name;
  int? id;
  String? createdAt;

  WarehouseListModel({this.name, this.id, this.createdAt});

  WarehouseListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['created_at'] = createdAt;
    return data;
  }
}
