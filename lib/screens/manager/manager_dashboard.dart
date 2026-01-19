import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../shared/account_page.dart';
import '../../services/notification_service.dart';

class ManagerDashboard extends StatefulWidget {
  final Function(int)? onTabChange;
  const ManagerDashboard({super.key, this.onTabChange});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDB7A6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4A4A4A),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'LOGO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.black, size: 28),
                        onPressed: () {
                          // Navigate to settings or show menu
                        },
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
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'DASHBOARD',
                style: GoogleFonts.cinzel(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
              // Dashboard Stats Container
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF9E8475),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildStatCard('TOTAL SHOPS', '40', () => widget.onTabChange?.call(1)),
                    _buildStatCard('ACTIVE SHOPS', '34', () => widget.onTabChange?.call(1)),
                    _buildStatCard('TOTAL ORDERS', '2345', () => widget.onTabChange?.call(2)),
                    _buildStatCard('TOTAL REVENUE', '₹ 3,05,040', () => widget.onTabChange?.call(3)),
                    _buildStatCard('COMMISSION', '₹ 58,000', () => widget.onTabChange?.call(3)),
                    _buildStatCard('ISSUES', NotificationService().notificationCount.toString().padLeft(2, '0'), () => widget.onTabChange?.call(0)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'PLATFORM ACTIVITY',
                style: GoogleFonts.cinzel(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 15),
              // Platform Activity Buttons
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF9E8475),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildActivityButton('ORDERS VS REVENUE', () => widget.onTabChange?.call(3)),
                    const SizedBox(height: 10),
                    _buildActivityButton('PEAK PICKUP TIME', () => widget.onTabChange?.call(2)),
                    const SizedBox(height: 10),
                    _buildActivityButton('GROWTH TREND', () => widget.onTabChange?.call(3)),
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

  Widget _buildStatCard(String label, String value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF6B584F),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text( label,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
