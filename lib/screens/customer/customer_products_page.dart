import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/product_service.dart';
import '../../models/product.dart';
import 'dart:io';
import 'product_details_page.dart';
import '../../services/cart_service.dart';

class CustomerProductsPage extends StatefulWidget {
  const CustomerProductsPage({super.key});

  @override
  State<CustomerProductsPage> createState() => _CustomerProductsPageState();
}

class _CustomerProductsPageState extends State<CustomerProductsPage> {
  String? _selectedCategory;
  final List<String> _categories = ['Groceries', 'Baby', 'Cosmetics', 'more'];

  @override
  Widget build(BuildContext context) {
    var products = ProductService().products.where((p) => !p.isDeleted && !p.isHidden).toList();
    
    if (_selectedCategory != null && _selectedCategory != 'more') {
      products = products.where((p) => p.category.toLowerCase() == _selectedCategory!.toLowerCase()).toList();
    }

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
            const SizedBox(height: 0),
            Text(
              'PRODUCTS',
              style: GoogleFonts.cinzel(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            _buildSearchBar(),
            const SizedBox(height: 15),
            _buildCategoryChips(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'POPULAR',
                        style: GoogleFonts.cinzel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: ' PRODUCTS',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(context, products[index]);
                },
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 30, color: Colors.black54),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search Products',
            hintStyle: GoogleFonts.outfit(color: Colors.black54),
            suffixIcon: const Icon(Icons.search, color: Colors.black),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: _categories.map((cat) {
          bool isSelected = _selectedCategory == cat;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = isSelected ? null : cat;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.black12,
                  width: 1,
                ),
              ),
              child: Text(
                cat,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: product.imagePath != null
                  ? (product.imagePath!.startsWith('assets/')
                      ? Image.asset(product.imagePath!, fit: BoxFit.contain)
                      : Image.file(File(product.imagePath!), fit: BoxFit.contain))
                  : const Icon(Icons.image, size: 40, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: GoogleFonts.cinzel(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  product.subtitle,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      product.price,
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.favorite, color: Colors.red, size: 20),
                  ],
                ),
                const SizedBox(height: 10),
                _buildButton(
                  'VIEW DETAILS',
                  const Color(0xFFA6CBE3),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(product: product),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                _buildButton(
                  'ADD TO CART', 
                  const Color(0xFFA6CBE3),
                  onTap: () {
                    CartService().addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name.replaceAll('\n', ' ')} added to cart'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        height: 32,
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.outfit(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
