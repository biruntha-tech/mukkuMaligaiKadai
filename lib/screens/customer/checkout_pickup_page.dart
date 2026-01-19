import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/cart_service.dart';
import '../../services/order_service.dart';
import '../../models/order_model.dart';

import '../shared/main_navigation.dart';

class CheckoutPickupPage extends StatefulWidget {
  const CheckoutPickupPage({super.key});

  @override
  State<CheckoutPickupPage> createState() => _CheckoutPickupPageState();
}

class _CheckoutPickupPageState extends State<CheckoutPickupPage> {
  String _selectedTime = '11:00 AM - 11:30 AM';
  String _selectedPayment = 'UPI PAYMENT';

  final List<String> _timeSlots = [
    '10:00 AM - 10:30 AM',
    '10:30 AM - 11:00 AM',
    '11:00 AM - 11:30 AM',
    '11:30 AM - 12:00 PM',
    '12:00 PM - 12:30 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDB7A6),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: Colors.white54, shape: BoxShape.circle),
                      child: const Icon(Icons.arrow_back_ios_new, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'CHECKOUT PICKUP',
              style: GoogleFonts.cinzel(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PICKUP TIME', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 15),
                    _buildSelectionBox(_timeSlots, _selectedTime, (val) => setState(() => _selectedTime = val)),
                    const SizedBox(height: 40),
                    Text('PAYMENT', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 15),
                    _buildSelectionBox(['CASH ON DELIVERY', 'UPI PAYMENT'], _selectedPayment, (val) => setState(() => _selectedPayment = val)),
                  ],
                ),
              ),
            ),
            _buildPlaceOrderBtn(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionBox(List<String> options, String current, Function(String) onSelect) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: options.map((opt) {
          bool isSelected = current == opt;
          return GestureDetector(
            onTap: () => onSelect(opt),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF907A65) : Colors.white60,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black26),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(opt, style: GoogleFonts.cinzel(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPlaceOrderBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: () {
          _handlePlaceOrder();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA59084),
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        child: Text('PLACE ORDER', style: GoogleFonts.cinzel(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
    );
  }

  void _handlePlaceOrder() {
    final cart = CartService();
    if (cart.items.isEmpty) return;

    final newOrder = OrderModel(
      orderId: (DateTime.now().millisecondsSinceEpoch % 10000).toString(),
      customerName: 'JOSE MILTON', // Mocked user
      paymentMethod: _selectedPayment,
      date: '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
      time: _selectedTime.split(' - ')[0],
      items: cart.items.map((item) => OrderItem(
        id: item.product.id,
        productName: item.product.name.replaceAll('\n', ' '),
        quantity: '${item.quantity} PCS',
        price: item.totalPrice,
      )).toList(),
      status: OrderStatus.newOrder,
    );

    OrderService().addOrder(newOrder);
    cart.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order placed successfully!')),
    );
    
    // Navigate to MainNavigationScreen and select the 'MY ORDERS' tab (index 3)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MainNavigationScreen(role: 'customer', initialIndex: 3),
      ),
      (route) => false,
    );
  }
}
