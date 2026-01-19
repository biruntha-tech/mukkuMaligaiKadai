import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavBar extends StatelessWidget {
  final String activeLabel;
  final Function(String) onTap;
  final String role;

  const CustomBottomNavBar({
    super.key,
    required this.activeLabel,
    required this.onTap,
    this.role = 'shopkeeper',
  });

  static const Color brandColor = Color(0xFF00FF80);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: role == 'customer' 
          ? [
              _buildBottomNavItem(context, 'HOME', Icons.home_outlined, Icons.home),
              _buildBottomNavItem(context, 'PRODUCTS', Icons.inventory_2_outlined, Icons.inventory_2),
              _buildBottomNavItem(context, 'ORDERS', Icons.receipt_long_outlined, Icons.receipt_long),
              _buildBottomNavItem(context, 'MY ORDERS', Icons.list_alt_outlined, Icons.list_alt),
              _buildBottomNavItem(context, 'ACCOUNT', Icons.person_outline, Icons.person),
            ]
          : role == 'manager'
          ? [
              _buildManagerNavItem('DASHBOARD'),
              _buildManagerNavItem('SHOPS'),
              _buildManagerNavItem('ORDERS'),
              _buildManagerNavItem('REVENUE'),
              _buildManagerNavItem('USERS'),
            ]
          : [
              _buildBottomNavItem(context, 'DASHBOARD', Icons.dashboard_outlined, Icons.dashboard),
              _buildBottomNavItem(context, 'PRODUCTS', Icons.inventory_2_outlined, Icons.inventory_2),
              _buildBottomNavItem(context, 'ORDERS', Icons.receipt_long_outlined, Icons.receipt_long),
              _buildBottomNavItem(context, 'ACCOUNT', Icons.person_outline, Icons.person),
            ],
      ),
    );
  }

  Widget _buildManagerNavItem(String label) {
    bool isActive = label == activeLabel;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(label),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFCDB7A6) : const Color(0xFFADD8E6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(BuildContext context, String label, IconData inactiveIcon, IconData activeIcon) {
    bool isActive = label == activeLabel;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(label),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isActive ? brandColor.withOpacity(0.2) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isActive ? activeIcon : inactiveIcon,
                  color: isActive ? const Color(0xFF00A352) : Colors.grey[600],
                  size: 26,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isActive ? const Color(0xFF00A352) : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
