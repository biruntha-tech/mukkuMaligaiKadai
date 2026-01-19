import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/cart_service.dart';
import 'dart:io';
import 'checkout_pickup_page.dart';

class CustomerCartPage extends StatefulWidget {
  const CustomerCartPage({super.key});

  @override
  State<CustomerCartPage> createState() => _CustomerCartPageState();
}

class _CustomerCartPageState extends State<CustomerCartPage> {
  final cart = CartService();

  @override
  Widget build(BuildContext context) {
    double tax = cart.totalItemsPrice * 0.05; // Example 5% tax
    double total = cart.totalItemsPrice + tax;

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
              'MY CART',
              style: GoogleFonts.cinzel(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: cart.items.isEmpty 
                ? Center(child: Text("Your cart is empty", style: GoogleFonts.outfit(fontSize: 18)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return _buildCartItem(item);
                    },
                  ),
            ),
            _buildSummary(tax, total),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: item.product.imagePath != null
                  ? (item.product.imagePath!.startsWith('assets/')
                      ? Image.asset(item.product.imagePath!, fit: BoxFit.contain)
                      : Image.file(File(item.product.imagePath!), fit: BoxFit.contain))
                  : const Icon(Icons.image, size: 24, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name.replaceAll('\n', ' '),
                  style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  item.product.price,
                  style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildQtyBtn(Icons.remove, () => setState(() => cart.updateQuantity(item.product.id, -1))),
              Container(
                width: 30,
                height: 30,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: const BoxDecoration(color: Colors.black26, shape: BoxShape.circle),
                child: Center(child: Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold))),
              ),
              _buildQtyBtn(Icons.add, () => setState(() => cart.updateQuantity(item.product.id, 1))),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => setState(() => cart.removeFromCart(item.product.id)),
                child: const Icon(Icons.delete_outline, size: 24, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: 20, color: Colors.black),
    );
  }

  Widget _buildSummary(double tax, double total) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            'PICKUP SUMMARY',
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFA59084),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                _buildSummaryRow('TOTAL ITEMS', '${cart.totalItemCount}'),
                const SizedBox(height: 12),
                _buildSummaryRow('TOTAL PRICE', '₹ ${cart.totalItemsPrice.toStringAsFixed(0)}'),
                const SizedBox(height: 12),
                _buildSummaryRow('TAX( IF ANY )', '₹ ${tax.toStringAsFixed(2)}'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('TOTAL', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(15)),
                child: Text('₹ ${total.toStringAsFixed(2)}', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (cart.items.isNotEmpty) {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutPickupPage()));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA59084),
              foregroundColor: Colors.black,
              minimumSize: const Size(200, 45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            child: Text('CONFIRM PICKUP', style: GoogleFonts.cinzel(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14)),
        Container(
          width: 80,
          height: 30,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text(value, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14))),
        ),
      ],
    );
  }
}
