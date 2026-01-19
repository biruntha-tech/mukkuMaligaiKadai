import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/product_service.dart';
import 'models/product.dart';
import 'dart:io';
import 'product_details_page.dart';
import 'services/wishlist_service.dart';
import 'main_navigation.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  final wishlistService = WishlistService();

  @override
  Widget build(BuildContext context) {
    final products = ProductService().products.where((p) => !p.isDeleted && !p.isHidden).toList();
    final wishlistItems = wishlistService.items;

    return Scaffold(
      backgroundColor: const Color(0xFFCDB7A6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 30),
              _buildSectionTitle('POPULAR', ' PRODUCTS'),
              _buildHorizontalProducts(products),
              const SizedBox(height: 30),
              _buildSectionTitle('PEOPLE MOSTLY', ' LIKED'),
              _buildHorizontalProducts(products.reversed.toList()),
              const SizedBox(height: 30),
              _buildWishlistSection(wishlistItems),
              const SizedBox(height: 20),
              const Center(
                child: Icon(Icons.keyboard_arrow_down, size: 40, color: Colors.black54),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xFF4A4A4A),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'LOGO',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                'SHOP NAME',
                style: GoogleFonts.cinzel(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainNavigationScreen(initialIndex: 3, role: 'customer'),
                ),
              );
            },
            child: const Icon(Icons.shopping_cart_outlined, size: 30),
          ),
        ],
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
            hintText: 'Search Products or shops',
            hintStyle: GoogleFonts.outfit(color: Colors.black54),
            suffixIcon: const Icon(Icons.search, color: Colors.black),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: GoogleFonts.cinzel(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: subtitle,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalProducts(List<Product> products) {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductDetailsPage(product: product)),
              );
              setState(() {}); // Refresh home page when coming back
            },
            child: Container(
              width: 100,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: product.imagePath != null
                    ? (product.imagePath!.startsWith('assets/')
                        ? Image.asset(product.imagePath!, fit: BoxFit.cover)
                        : Image.file(File(product.imagePath!), fit: BoxFit.cover))
                    : const Icon(Icons.image, color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWishlistSection(List<Product> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text(
                'WISHLIST',
                style: GoogleFonts.cinzel(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.favorite, color: Colors.red, size: 24),
            ],
          ),
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductDetailsPage(product: product)),
                  );
                  setState(() {}); // Refresh home page when coming back
                },
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: product.imagePath != null
                        ? (product.imagePath!.startsWith('assets/')
                            ? Image.asset(product.imagePath!, fit: BoxFit.cover)
                            : Image.file(File(product.imagePath!), fit: BoxFit.cover))
                        : const Icon(Icons.image, size: 20, color: Colors.grey),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
