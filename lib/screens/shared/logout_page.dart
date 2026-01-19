import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  static const Color brandColor = Colors.white;
  static const Color bgColor = Color(0xFFCDB7A6);
  static const Color cardColor = Color(0x99FFFFFF); // Colors.white.withOpacity(0.6)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: brandColor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Logout',
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Are you sure want to logout?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'You will need to sign in again\nto access your account.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 50),
                _buildLargeButton(context, 'Log out', isLogout: true),
                const SizedBox(height: 20),
                _buildLargeButton(context, 'Cancel', isLogout: false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLargeButton(BuildContext context, String label, {required bool isLogout}) {
    return GestureDetector(
      onTap: () {
        if (isLogout) {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        } else {
          Navigator.pop(context);
        }
      },
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: isLogout ? const Color(0xFFC62828).withOpacity(0.1) : brandColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isLogout ? const Color(0xFFC62828).withOpacity(0.3) : brandColor.withOpacity(0.3),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isLogout ? const Color(0xFFC62828) : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
