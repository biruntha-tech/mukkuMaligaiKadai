import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../shared/account_page.dart';

class ManagerOrdersPage extends StatelessWidget {
  const ManagerOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDB7A6),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.black, size: 28),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.account_circle, color: Colors.black, size: 28),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountPage(role: 'manager'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Text(
              'ORDERS',
              style: GoogleFonts.cinzel(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'NEW ORDERS',
                  style: GoogleFonts.cinzel(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Orders List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildOrderCard('1482', 'DHRUVA STORE', '₹ 450', '09.12.2025', '09:15 AM', 'PROCESSING'),
                  _buildOrderCard('1482', 'MANO STORES', '₹ 500', '08.12.2025', '10:25 AM', 'READY FOR PICKUP'),
                  _buildOrderCard('1482', 'DHRUVA STORE', '₹ 606', '06.12.2025', '11:15 AM', 'COMPLETED'),
                  const Icon(Icons.keyboard_arrow_down, size: 40, color: Color(0xFF5D4037)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(String id, String shop, String amount, String date, String time, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          _buildOrderRow('ORDER ID', id),
          _buildOrderRow('SHOP NAME', shop),
          _buildOrderRow('AMOUNT', amount),
          _buildOrderRow('DATE', date),
          _buildOrderRow('TIME', time),
          _buildOrderRow('STATUS', status),
        ],
      ),
    );
  }

  Widget _buildOrderRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
