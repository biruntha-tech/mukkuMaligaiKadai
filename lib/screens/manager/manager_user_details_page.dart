import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagerUserDetailsPage extends StatelessWidget {
  const ManagerUserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDB7A6),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Back Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Users',
                    hintStyle: GoogleFonts.outfit(color: Colors.grey[600]),
                    border: InputBorder.none,
                    suffixIcon: const Icon(Icons.search, color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Details Card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'USER DETAILS',
                        style: GoogleFonts.cinzel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildDetailRow('ORDER ID', '1482'),
                      _buildDetailRow('NAME', 'JOSE MILTON'),
                      const SizedBox(height: 20),
                      // Date Selector
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9E8475),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'DATE',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'DD/MM/YYYY',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // DateTime Label
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9E8475),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '25 01 2026 - 11.02 AM',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Order Items Table
                      Expanded(
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                _HeaderCell('S.NO', 1),
                                _HeaderCell('PRODUCT', 2),
                                _HeaderCell('QUANTITY', 1.5),
                                _HeaderCell('PRICE', 1),
                              ],
                            ),
                            const Divider(color: Colors.black26),
                            Expanded(
                              child: ListView(
                                children: [
                                  _buildItemRow('1', 'EGG', '6 PCS', '₹ 36'),
                                  _buildItemRow('2', 'TURMERIC', '250 G', '₹ 55'),
                                  _buildItemRow('3', 'RICE', '2 KG', '₹ 110'),
                                  _buildItemRow('4', 'SHAMPOO', '20 PCS', '₹ 40'),
                                  _buildItemRow('5', 'TOMATO', '2 KG', '₹ 80'),
                                  _buildItemRow('6', 'MILK', '1 LTR', '₹ 76'),
                                  _buildItemRow('7', 'BISCUIT', '3 PACKS', '₹ 30'),
                                ],
                              ),
                            ),
                            const Divider(color: Colors.black26),
                            _buildTotalRow('TOTAL', '₹ 427'),
                            const SizedBox(height: 10),
                            const Icon(Icons.keyboard_arrow_down, size: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
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

  Widget _buildItemRow(String sno, String product, String qty, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          _DataCell(sno, 1),
          _DataCell(product, 2),
          _DataCell(qty, 1.5),
          _DataCell(price, 1),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const Spacer(flex: 3),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 40),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  final double flex;
  const _HeaderCell(this.text, this.flex);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: (flex * 10).toInt(),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.outfit(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  final double flex;
  const _DataCell(this.text, this.flex);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: (flex * 10).toInt(),
      child: (flex == 2) // Product left aligned
          ? Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )
          : Center(
              child: Text(
                text,
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
    );
  }
}
