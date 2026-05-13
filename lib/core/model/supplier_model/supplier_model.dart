class SupplierModel {
  String? name;
  String? email;
  String? phone;
  String? address;
  String? contactName;
  String? status;
  int? rating;
  int? id;
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
    this.warehouseId,
  });

  SupplierModel.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    email = json['email']?.toString();
    phone = json['phone'].toString();
    address = json['address']?.toString();
    contactName = json['contact_name']?.toString();
    status = json['status']?.toString();
    rating = double.tryParse(json['rating'].toString())?.toInt();
    id = int.tryParse(json['id'].toString());
    warehouseId = int.tryParse(json['warehouse_id'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (contactName != null) data['contact_name'] = contactName;
    if (email != null) data['email'] = email;
    if (address != null) data['address'] = address;
    if (phone != null) data['phone'] = phone;
    if (status != null) data['status'] = status;
    if (rating != null) data['rating'] = rating;
    if (id != null) data['id'] = id;
    if (warehouseId != null) data['warehouse_id'] = warehouseId;
    return data;
  }
}
