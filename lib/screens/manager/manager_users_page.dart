import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../shared/account_page.dart';
import 'manager_user_details_page.dart';

class ManagerUsersPage extends StatelessWidget {
  const ManagerUsersPage({super.key});

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
              'USERS',
              style: GoogleFonts.cinzel(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            // User Table
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9E8475),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: [
                            _HeaderCell('USER ID', 1),
                            _HeaderCell('NAME', 1.5),
                            _HeaderCell('ORDERS', 1),
                            _HeaderCell('STATUS', 1),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView(
                          children: [
                            _buildUserRow(context, '1482', 'JOSE', '12', 'ACTIVE'),
                            _buildUserRow(context, '1524', 'RITHIKA', '09', 'DISABLED'),
                            _buildUserRow(context, '1637', 'MANO', '13', 'BLOCKED'),
                            _buildUserRow(context, '1289', 'DHRUVA', '14', 'ACTIVE'),
                            _buildUserRow(context, '1467', 'SHARON', '18', 'ACTIVE'),
                            _buildUserRow(context, '1289', 'DINO', '24', 'ACTIVE'),
                            _buildUserRow(context, '1376', 'KING', '33', 'BLOCKED'),
                            _buildUserRow(context, '1342', 'MAXY', '13', 'ACTIVE'),
                            _buildUserRow(context, '1234', 'VARSHA', '18', 'ACTIVE'),
                            _buildUserRow(context, '1432', 'BLESSY', '11', 'DISABLED'),
                            _buildUserRow(context, '1323', 'BEULAH', '10', 'ACTIVE'),
                            _buildUserRow(context, '1433', 'CERLO', '16', 'ACTIVE'),
                            _buildUserRow(context, '1444', 'MONISHA', '14', 'DISABLED'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ManagerUserDetailsPage()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B7366),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'VIEW DETAILS',
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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

  Widget _buildUserRow(BuildContext context, String id, String name, String orders, String status) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ManagerUserDetailsPage()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            _DataCell(id, 1),
            _DataCell(name, 1.5),
            _DataCell(orders, 1),
            _DataCell(status, 1),
          ],
        ),
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
