import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/order_model.dart';

class CustomerOrderDetailsPage extends StatelessWidget {
  final OrderModel order;
  const CustomerOrderDetailsPage({super.key, required this.order});

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
            const SizedBox(height: 50),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Text(
                      'ORDER DETAILS',
                      style: GoogleFonts.cinzel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildTopRow('ORDER ID', order.orderId),
                    _buildTopRow('NAME', order.customerName),
                    _buildTopRow('PAYMENT', order.paymentMethod),
                    _buildTopRow('DATE', order.date),
                    _buildTopRow('TIME', order.time),
                    const SizedBox(height: 40),
                    _buildTableHeaders(),
                    const Divider(color: Colors.black26),
                    Expanded(
                      child: ListView.builder(
                        itemCount: order.items.length,
                        itemBuilder: (context, index) {
                          final item = order.items[index];
                          return _buildTableRow(index + 1, item);
                        },
                      ),
                    ),
                    const Divider(color: Colors.black26),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('TOTAL', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(width: 30),
                          Text('₹ ${order.totalAmount.toStringAsFixed(0)}', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Text(value, style: GoogleFonts.outfit(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildTableHeaders() {
    return Row(
      children: [
        SizedBox(width: 40, child: Text('S.NO', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 12))),
        Expanded(flex: 3, child: Text('PRODUCT', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 12))),
        Expanded(flex: 2, child: Center(child: Text('QUANTITY', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 12)))),
        Expanded(flex: 2, child: Align(alignment: Alignment.centerRight, child: Text('PRICE', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 12)))),
      ],
    );
  }

  Widget _buildTableRow(int index, OrderItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(width: 40, child: Text('$index', style: GoogleFonts.outfit(fontSize: 14))),
          Expanded(flex: 3, child: Text(item.productName, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Center(child: Text(item.quantity, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold)))),
          Expanded(flex: 2, child: Align(alignment: Alignment.centerRight, child: Text('₹ ${item.price.toStringAsFixed(0)}', style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold)))),
        ],
      ),
    );
  }
}
