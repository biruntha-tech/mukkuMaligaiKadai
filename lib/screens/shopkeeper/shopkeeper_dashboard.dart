import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_product_page.dart';
import 'manage_stocks_page.dart';
import '../shared/main_navigation.dart';

class ShopkeeperDashboard extends StatelessWidget {
  final Function(int)? onTabChange;
  const ShopkeeperDashboard({super.key, this.onTabChange});

  static const Color brandColor = Colors.white;
  static const Color bgColor = Color(0xFFCDB7A6);
  static const Color cardColor = Color(0x99FFFFFF); // Colors.white.withOpacity(0.6)

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Shopkeeper',
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Stats Card
              Container(
                padding: const EdgeInsets.all(24),
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
                    _buildStatRow("TODAY'S SALES", "₹ 2500", isCurrency: true),
                    const SizedBox(height: 20),
                    _buildStatRow("TOTAL ORDERS TODAY", "8"),
                    const SizedBox(height: 20),
                    _buildStatRow("PENDING ORDERS", "4"),
                    const SizedBox(height: 20),
                    _buildStatRow("LOW STOCKS", "2"),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              // Actions Grid
              Container(
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
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 2.2,
                  children: [
                    _buildActionButton(
                      Icons.add_circle,
                      "ADD\nPRODUCTS",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddProductPage()),
                        );
                      },
                    ),
                    _buildActionButton(
                      Icons.inventory, 
                      "MANAGE\nSTOCKS",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ManageStocksPage()),
                        );
                      },
                    ),
                    _buildActionButton(
                      Icons.shopping_cart_checkout, 
                      "ORDER\nOVERVIEW",
                      onTap: () {
                        if (onTabChange != null) {
                          onTabChange!(2);
                        }
                      },
                    ),
                    _buildActionButton(Icons.description, "SALES\nREPORT"),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              // Recent Orders Card
              Container(
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
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
                    const SizedBox(height: 20),
                    _buildOrderRow("ORDER - 234 - EGG - 2 PCS - DELIVERED"),
                    _buildOrderRow("ORDER - 234 - CARROT - 3 KG - PENDING"),
                    _buildOrderRow("ORDER - 234 - TISSUE - 5 PACK - PACKED"),
                    _buildOrderRow("ORDER - 234 - TURMERIC - 2PCS - PACKED"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, {bool isCurrency = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: brandColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: brandColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.assignment, size: 28, color: Colors.white),
          const SizedBox(width: 12),
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
