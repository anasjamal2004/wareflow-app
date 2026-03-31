class InventoryModel {
  String? sku;
  String? name;
  String? category;
  int? quantity;
  int? minStock;
  int? price;
  String? location;
  int? supplierId;
  int? id;
  int? warehouseId;

  InventoryModel({
    this.sku,
    this.name,
    this.category,
    this.quantity,
    this.minStock,
    this.price,
    this.location,
    this.supplierId,
    this.id,
    this.warehouseId,
  });

  InventoryModel.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    name = json['name'];
    category = json['category'];
    quantity = json['quantity'];
    minStock = json['min_stock'];
    price = json['price'];
    location = json['location'];
    supplierId = json['supplier_id'];
    id = json['id'];
    warehouseId = json['warehouse_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['name'] = this.name;
    data['category'] = this.category;
    data['quantity'] = this.quantity;
    data['min_stock'] = this.minStock;
    data['price'] = this.price;
    data['location'] = this.location;
    data['supplier_id'] = this.supplierId;
    data['id'] = this.id;
    data['warehouse_id'] = this.warehouseId;
    return data;
  }
}
