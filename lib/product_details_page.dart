import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/product.dart';
import 'services/product_service.dart';
import 'dart:io';
import 'services/cart_service.dart';
import 'services/wishlist_service.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final relatedProducts = ProductService().products
        .where((p) => p.id != widget.product.id && p.category == widget.product.category && !p.isDeleted && !p.isHidden)
        .take(5)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFCDB7A6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildAppBar(context),
              const SizedBox(height: 10),
              _buildProductCard(),
              const SizedBox(height: 20),
              _buildRelatedSection(relatedProducts),
              const Icon(Icons.keyboard_arrow_down, size: 30, color: Colors.black54),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new, size: 24),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'PRODUCT DETAILS',
                style: TextStyle(
                  fontFamily: 'Cinzel',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 24), // Placeholder for balance
        ],
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  WishlistService().toggleWishlist(widget.product);
                });
              },
              child: Icon(
                WishlistService().isInWishlist(widget.product.id) ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
                size: 28,
              ),
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: widget.product.imagePath != null
                  ? (widget.product.imagePath!.startsWith('assets/')
                      ? Image.asset(widget.product.imagePath!, fit: BoxFit.contain)
                      : Image.file(File(widget.product.imagePath!), fit: BoxFit.contain))
                  : const Icon(Icons.image, size: 80, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.product.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.cinzel(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.product.subtitle,
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            widget.product.price,
            style: GoogleFonts.outfit(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${widget.product.stocks} STOCKS MORE',
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildQtyBtn(Icons.remove, () {
                if (_quantity > 1) setState(() => _quantity--);
              }),
              const SizedBox(width: 15),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$_quantity',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 15),
              _buildQtyBtn(Icons.add, () => setState(() => _quantity++)),
            ],
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              for (int i = 0; i < _quantity; i++) {
                CartService().addToCart(widget.product);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${widget.product.name.replaceAll('\n', ' ')} added to cart'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB19D92),
              foregroundColor: Colors.black,
              minimumSize: const Size(200, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 0,
            ),
            child: Text(
              'ADD TO CART',
              style: GoogleFonts.cinzel(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: Colors.black, size: 24),
    );
  }

  Widget _buildRelatedSection(List<Product> products) {
    return Column(
      children: [
        const Text(
          'RELATED PRODUCTS',
          style: TextStyle(
            fontFamily: 'Cinzel',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
