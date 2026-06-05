class OrderModel {
  String? orderType;
  int? supplierId;
  num? totalValue;
  String? status;
  String? notes;
  int? id;
  String? orderNumber;
  String? orderDate;
  int? warehouseId;
  List<OrderItem>? items;

  OrderModel({
    this.orderType,
    this.supplierId,
    this.totalValue,
    this.status,
    this.notes,
    this.id,
    this.orderNumber,
    this.orderDate,
    this.warehouseId,
    this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderType: json['order_type'],
      supplierId: json['supplier_id'],
      totalValue: json['total_value'] as num?, // 🎯 Fixed casting
      status: json['status'],
      notes: json['notes'],
      id: json['id'],
      orderNumber: json['order_number'],
      orderDate: json['order_date'],
      warehouseId: json['warehouse_id'],
      items: json['items'] != null
          ? (json['items'] as List).map((i) => OrderItem.fromJson(i)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_type': orderType?.toLowerCase(),
      'supplier_id': supplierId,
      'total_value': totalValue,
      'status': status,
      'notes': notes,
      'warehouse_id': warehouseId,
      'items': items?.map((v) => v.toJson()).toList(),
    };
  }
}

class OrderItem {
  num? productId;
  num? quantity;
  num? priceAtOrder;

  OrderItem({this.productId, this.quantity, this.priceAtOrder});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'] as num?,
      quantity: json['quantity'] as num?,
      priceAtOrder:
          (json['price_at_time'] as num?) ?? (json['price_at_order'] as num?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'price_at_time': priceAtOrder,
    };
  }
}
