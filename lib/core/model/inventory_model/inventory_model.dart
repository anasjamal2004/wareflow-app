class InventoryModel {
  String? sku;
  String? name;
  String? category;
  num? quantity;
  int? minStock;
  num? price;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sku != null) data['sku'] = sku;
    if (name != null) data['name'] = name;
    if (category != null) data['category'] = category;
    if (quantity != null) data['quantity'] = quantity;
    if (minStock != null) data['min_stock'] = minStock;
    if (price != null) data['price'] = price;
    if (location != null) data['location'] = location;
    if (supplierId != null) data['supplier_id'] = supplierId;
    if (id != null) data['id'] = id;
    if (warehouseId != null) data['warehouse_id'] = warehouseId;
    return data;
  }
}
