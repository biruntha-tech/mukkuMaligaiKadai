import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'new_orders_page.dart';
import 'processing_orders_page.dart';
import 'orders_list_page.dart';
import 'services/order_service.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  static const Color brandColor = Color(0xFF00FF80);
  static const Color bgColor = Color(0xFFE0FFF0);
  static const Color cardColor = Color(0xB3E6E1F9);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                'ORDERS',
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 40),
              _buildMenuButton(context, 'NEW ORDERS', const NewOrdersPage()),
              _buildMenuButton(context, 'PROCESSING ORDERS', const ProcessingOrdersPage()),
              _buildMenuButton(
                context,
                'COMPLETED',
                OrdersListPage(title: 'COMPLETED', orders: OrderService().completedOrders)
              ),
              _buildMenuButton(
                context,
                'CANCELLED',
                OrdersListPage(title: 'CANCELLED', orders: OrderService().rejectedOrders)
              ),
              const SizedBox(height: 40),
              // Recent Orders Container
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: brandColor.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                        decoration: BoxDecoration(
                          color: brandColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'RECENT ORDERS',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      _buildRecentOrderRow('ORDER - 238 - SHARON - DELIVERED'),
                      _buildRecentOrderRow('ORDER - 237 - AARTHI - PENDING'),
                      _buildRecentOrderRow('ORDER - 236 - SANDHIYA - PACKED'),
                      _buildRecentOrderRow('ORDER - 235 - DINOSON - PENDING'),
                      _buildRecentOrderRow('ORDER - 234 - KINGSTON - PACKED'),
                      _buildRecentOrderRow('ORDER - 233 - BLESSY - DELIVERED'),
                      const SizedBox(height: 10),
                      const Icon(Icons.keyboard_arrow_down, size: 40, color: Color(0xFF00A352)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String label, Widget? targetPage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      child: GestureDetector(
        onTap: () {
          if (targetPage != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => targetPage),
            );
          }
        },
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: brandColor.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentOrderRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          const Icon(Icons.assignment_outlined, size: 32, color: Color(0xFF00A352)),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
