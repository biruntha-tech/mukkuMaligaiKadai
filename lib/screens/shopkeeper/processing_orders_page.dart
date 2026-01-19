import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/order_service.dart';

class ProcessingOrdersPage extends StatefulWidget {
  const ProcessingOrdersPage({super.key});

  @override
  State<ProcessingOrdersPage> createState() => _ProcessingOrdersPageState();
}

class _ProcessingOrdersPageState extends State<ProcessingOrdersPage> {
  static const Color brandColor = Colors.white;
  static const Color bgColor = Color(0xFFCDB7A6);
  static const Color cardColor = Color(0x99FFFFFF); // Colors.white.withOpacity(0.6)

  @override
  Widget build(BuildContext context) {
    final orders = OrderService().processingOrders;

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
                'PROCESSING ORDERS',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: orders.isEmpty 
                ? Center(child: Text("No processing orders", style: GoogleFonts.outfit(fontSize: 18, color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: orders.length + 1,
                    itemBuilder: (context, index) {
                      if (index == orders.length) {
                        return const Column(
                          children: [
                            SizedBox(height: 10),
                            Icon(Icons.keyboard_arrow_down, size: 40, color: Color(0xFF6B584F)),
                          ],
                        );
                      }
                      final order = orders[index];
                      return _buildProcessingCard(order.orderId, order.customerName, progress: 1);
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingCard(String id, String name, {required int progress}) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'ORDER ID',
                style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 40),
              Text(
                id,
                style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'NAME',
                style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 75),
              Text(
                name,
                style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 25),
          // Progress Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProgressDot('ACCEPTED', progress >= 1),
              _buildProgressLine(progress >= 2),
              _buildProgressDot('PACKED', progress >= 2),
              _buildProgressLine(progress >= 3),
              _buildProgressDot('READY TO\nDELIVER', progress >= 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressDot(String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.grey[300],
            shape: BoxShape.circle,
            border: Border.all(color: brandColor.withOpacity(0.1), width: 5),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 6,
        margin: const EdgeInsets.only(bottom: 25),
        color: isActive ? Colors.white : Colors.grey[300],
      ),
    );
  }
}
