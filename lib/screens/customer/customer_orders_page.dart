import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/order_service.dart';
import '../../models/order_model.dart';
import 'customer_order_details_page.dart';

class CustomerOrdersPage extends StatelessWidget {
  const CustomerOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = OrderService().allOrders;

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
            Text(
              'MY ORDERS',
              style: GoogleFonts.cinzel(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: orders.isEmpty
                ? Center(child: Text("No orders yet", style: GoogleFonts.outfit(fontSize: 18)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return _buildOrderCard(context, orders[index]);
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderModel order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          _buildDetailRow('ORDER ID', order.orderId),
          _buildDetailRow('AMOUNT', '₹ ${order.totalAmount.toStringAsFixed(0)}'),
          _buildDetailRow('STATUS', order.status.name.toUpperCase()),
          _buildDetailRow('PICK UP TIME', '${order.time} - 11:30 AM'), // Mocked end time
          _buildDetailRow('DATE', order.date),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => CustomerOrderDetailsPage(order: order))
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB19D92),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              minimumSize: const Size(120, 35),
            ),
            child: Text('VIEW', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          Text(value, style: GoogleFonts.outfit(fontWeight: FontWeight.w500, fontSize: 14)),
        ],
      ),
    );
  }
}
