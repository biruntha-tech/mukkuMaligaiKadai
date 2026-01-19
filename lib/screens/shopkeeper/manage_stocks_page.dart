import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/product_service.dart';
import '../../models/product.dart';
import '../../services/notification_service.dart';

class ManageStocksPage extends StatefulWidget {
  const ManageStocksPage({super.key});

  @override
  State<ManageStocksPage> createState() => _ManageStocksPageState();
}

class _ManageStocksPageState extends State<ManageStocksPage> {
  static const Color brandColor = Colors.white;
  static const Color bgColor = Color(0xFFCDB7A6);
  static const Color cardColor = Color(0x99FFFFFF); // Colors.white.withOpacity(0.6)

  @override
  Widget build(BuildContext context) {
    final products = ProductService().products.where((p) => !p.isDeleted).toList();

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
          'MANAGE STOCKS',
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return _buildStockCard(product);
          },
        ),
      ),
    );
  }

  Widget _buildStockCard(Product product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name.replaceAll('\n', ' '),
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  product.category,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product.price,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF007A3D),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: brandColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                _buildQuantityBtn(Icons.remove, () {
                  if (product.stocks > 0) {
                    setState(() {
                      product.stocks--;
                      ProductService().updateProduct(product.id, product);
                    });
                  }
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    product.stocks.toString(),
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                _buildQuantityBtn(Icons.add, () {
                  setState(() {
                    product.stocks++;
                    ProductService().updateProduct(product.id, product);
                  });
                }),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              NotificationService().addNotification("Restock requested for: ${product.name}");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Restock request sent for ${product.name.replaceAll('\n', ' ')}'),
                  backgroundColor: Colors.white,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.refresh,
                color: Color(0xFF6B584F),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: Colors.white),
      ),
    );
  }
}
