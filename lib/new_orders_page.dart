import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/order_service.dart';
import 'models/order_model.dart';
import 'order_details_page.dart';

class NewOrdersPage extends StatefulWidget {
  const NewOrdersPage({super.key});

  @override
  State<NewOrdersPage> createState() => _NewOrdersPageState();
}

class _NewOrdersPageState extends State<NewOrdersPage> {
  static const Color brandColor = Color(0xFF00FF80);
  static const Color bgColor = Color(0xFFE0FFF0);
  static const Color cardColor = Color(0xB3E6E1F9);

  @override
  Widget build(BuildContext context) {
    final orders = OrderService().newOrders;

    return Scaffold(
      backgroundColor: bgColor,
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
                      decoration: const BoxDecoration(
                        color: Colors.white54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'NEW ORDERS',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                itemCount: orders.length + 1, // +1 for the arrow icon
                itemBuilder: (context, index) {
                  if (index == orders.length) {
                    return const Column(
                      children: [
                        SizedBox(height: 10),
                        Icon(Icons.keyboard_arrow_down, size: 50, color: Color(0xFF00A352)),
                        SizedBox(height: 20),
                      ],
                    );
                  }
                  final order = orders[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailsPage(order: order),
                        ),
                      ).then((_) => setState(() {})); // Refresh list after returning
                    },
                    child: _buildOrderCard(
                      order.orderId,
                      order.customerName,
                      '₹ ${order.totalAmount.toStringAsFixed(0)}',
                      order.date,
                      order.time,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(String id, String name, String amount, String date, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: brandColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow('ORDER ID', id),
          const SizedBox(height: 12),
          _buildDetailRow('NAME', name),
          const SizedBox(height: 12),
          _buildDetailRow('AMOUNT', amount, isPrice: true),
          const SizedBox(height: 12),
          _buildDetailRow('DATE', date),
          const SizedBox(height: 12),
          _buildDetailRow('TIME', time),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isPrice = false}) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isPrice ? const Color(0xFF007A3D) : Colors.black.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }
}
