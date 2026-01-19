import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/order_model.dart';
import 'order_details_page.dart';

class OrdersListPage extends StatelessWidget {
  final String title;
  final List<OrderModel> orders;
  const OrdersListPage({super.key, required this.title, required this.orders});

  static const Color brandColor = Color(0xFF00FF80);
  static const Color bgColor = Color(0xFFE0FFF0);
  static const Color cardColor = Color(0xB3E6E1F9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: orders.isEmpty 
          ? Center(child: Text("No $title found", style: GoogleFonts.outfit(fontSize: 18, color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsPage(order: order),
                      ),
                    );
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
          width: 100,
          child: Text(
            label,
            style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isPrice ? const Color(0xFF007A3D) : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
