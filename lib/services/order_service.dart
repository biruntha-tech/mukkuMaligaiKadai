import '../models/order_model.dart';

class OrderService {
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  final List<OrderModel> _orders = [
    OrderModel(
      orderId: '1482',
      customerName: 'JOSE MILTON',
      paymentMethod: 'UPI',
      date: '09.12.2025',
      time: '09:15 AM',
      items: [
        OrderItem(id: '1', productName: 'EGG', quantity: '6 PCS', price: 36),
        OrderItem(id: '2', productName: 'TURMERIC', quantity: '250 G', price: 55),
        OrderItem(id: '3', productName: 'RICE', quantity: '2 KG', price: 110),
        OrderItem(id: '4', productName: 'SHAMPOO', quantity: '20 PCS', price: 40),
        OrderItem(id: '5', productName: 'TOMATO', quantity: '2 KG', price: 80),
        OrderItem(id: '6', productName: 'MILK', quantity: '1 LTR', price: 76),
        OrderItem(id: '7', productName: 'BISCUIT', quantity: '3 PACKS', price: 30),
      ],
    ),
    OrderModel(
      orderId: '1481',
      customerName: 'RITHIKA',
      paymentMethod: 'CASH',
      date: '09.12.2025',
      time: '10:17 AM',
      items: [
        OrderItem(id: '1', productName: 'MILK', quantity: '2 LTR', price: 152),
        OrderItem(id: '2', productName: 'BREAD', quantity: '1 PACK', price: 48),
      ],
    ),
    OrderModel(
      orderId: '1480',
      customerName: 'VARSHA',
      paymentMethod: 'UPI',
      date: '09.12.2025',
      time: '12:15 PM',
      items: [
        OrderItem(id: '1', productName: 'COOKING OIL', quantity: '1 LTR', price: 190),
        OrderItem(id: '2', productName: 'DAL', quantity: '5 KG', price: 600),
      ],
    ),
  ];

  List<OrderModel> get newOrders => _orders.where((o) => o.status == OrderStatus.newOrder).toList();
  List<OrderModel> get processingOrders => _orders.where((o) => o.status == OrderStatus.processing).toList();
  List<OrderModel> get rejectedOrders => _orders.where((o) => o.status == OrderStatus.rejected).toList();
  List<OrderModel> get completedOrders => _orders.where((o) => o.status == OrderStatus.completed).toList();

  void acceptOrder(String orderId) {
    final index = _orders.indexWhere((o) => o.orderId == orderId);
    if (index != -1) {
      _orders[index].status = OrderStatus.processing;
    }
  }

  void hideProduct(String id) {
    final index = _orders.indexWhere((o) => o.orderId == id);
    if (index != -1) {
      _orders[index].status = OrderStatus.rejected; // Mock logic for hide
    }
  }

  void addOrder(OrderModel order) {
    _orders.insert(0, order);
  }

  List<OrderModel> get allOrders => _orders;

  void rejectOrder(String orderId) {
    final index = _orders.indexWhere((o) => o.orderId == orderId);
    if (index != -1) {
      _orders[index].status = OrderStatus.rejected;
    }
  }

  void updateOrder(OrderModel updatedOrder) {
    final index = _orders.indexWhere((o) => o.orderId == updatedOrder.orderId);
    if (index != -1) {
      _orders[index] = updatedOrder;
    }
  }
}
