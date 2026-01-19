enum OrderStatus { newOrder, processing, rejected, completed }

class OrderItem {
  final String id;
  String productName;
  String quantity;
  double price;
  bool isSelected;

  OrderItem({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.price,
    this.isSelected = false,
  });

  OrderItem copyWith({
    String? productName,
    String? quantity,
    double? price,
    bool? isSelected,
  }) {
    return OrderItem(
      id: this.id,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class OrderModel {
  final String orderId;
  final String customerName;
  final String paymentMethod;
  final String date;
  final String time;
  List<OrderItem> items;
  OrderStatus status;

  OrderModel({
    required this.orderId,
    required this.customerName,
    required this.paymentMethod,
    required this.date,
    required this.time,
    required this.items,
    this.status = OrderStatus.newOrder,
  });

  double get totalAmount => items.fold(0, (sum, item) => sum + item.price);
}
