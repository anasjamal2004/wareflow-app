class SupplierModel {
  final int? id; // IDs hamesha int hote hain
  final String? name;
  final String? contactName;
  final String? email;
  final String? phone;
  final String? address;
  final String? status;
  final num? rating; // 👈 FIX: Rating int/double dono ho sakti hai, isliye 'num'
  final int? warehouseId; // Warehouse ID int hi rahegi

  SupplierModel({
    this.id,
    this.name,
    this.contactName,
    this.email,
    this.phone,
    this.address,
    this.status,
    this.rating,
    this.warehouseId,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      id: json['id'],
      name: json['name'],
      contactName: json['contact_name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      status: json['status'],
      // 🎯 FIX: Cast to 'num?' so it doesn't crash on 0.0 or 5
      rating: json['rating'] as num?, 
      warehouseId: json['warehouse_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contact_name': contactName,
      'email': email,
      'phone': phone,
      'address': address,
      'status': status,
      'rating': rating,
      'warehouse_id': warehouseId,
    };
  }
}