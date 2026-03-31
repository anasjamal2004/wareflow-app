class SupplierModel {
  String? name;
  String? contactName;
  String? email;
  int? phone;
  String? address;
  String? status;
  int? rating;
  int? id;
  int? supplierId;
  int? warehouseId;

  SupplierModel({
    this.name,
    this.contactName,
    this.email,
    this.phone,
    this.address,
    this.status,
    this.rating,
    this.id,
    this.supplierId,
    this.warehouseId,
  });

  SupplierModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    contactName = json['contact_name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    status = json['status'];
    rating = json['rating'];
    id = json['id'];
    supplierId = json['supplierId'];
    warehouseId = json['warehouse_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['contact_name'] = contactName;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['status'] = status;
    data['rating'] = rating;
    data['id'] = id;
    data['supplierId'] = supplierId;
    data['warehouse_id'] = warehouseId;
    return data;
  }
}
