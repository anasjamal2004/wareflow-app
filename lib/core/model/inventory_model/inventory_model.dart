class InventoryModel {
  final int? id;
  final String? name;
  final String? sku;
  final String? category;
  final int? quantity;
  final int? minStock;
  final double? price;
  final String? location;
  final int? supplierId; // 👈 Backend se "supplier_id" aa raha hai
  final int? warehouseId;

  InventoryModel({
    this.id,
    this.name,
    this.sku,
    this.category,
    this.quantity,
    this.minStock,
    this.price,
    this.location,
    this.supplierId,
    this.warehouseId,
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) {
    return InventoryModel(
      id: json['id'],
      name: json['name'],
      sku: json['sku'],
      category: json['category'],
      quantity: json['quantity'],
      minStock: json['min_stock'],
      price: (json['price'] as num?)?.toDouble(),
      location: json['location'],
      supplierId: json['supplier_id'], // 👈 Mapping fixed here
      warehouseId: json['warehouse_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'category': category,
      'quantity': quantity,
      'min_stock': minStock,
      'price': price,
      'location': location,
      'supplier_id': supplierId,
      'warehouse_id': warehouseId,
    };
  }
}
