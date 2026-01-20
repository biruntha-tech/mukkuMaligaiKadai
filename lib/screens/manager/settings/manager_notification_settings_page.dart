import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagerNotificationSettingsPage extends StatefulWidget {
  const ManagerNotificationSettingsPage({super.key});

  @override
  State<ManagerNotificationSettingsPage> createState() => _ManagerNotificationSettingsPageState();
}

class _ManagerNotificationSettingsPageState extends State<ManagerNotificationSettingsPage> {
  bool _emailNotifs = true;
  bool _pushNotifs = true;
  bool _smsNotifs = false;
  
  bool _newOrder = true;
  bool _registration = true;
  bool _paymentAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Notification Settings',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("Channels"),
            const SizedBox(height: 10),
            _buildSwitchTile("Email Notifications", _emailNotifs, (val) => setState(() => _emailNotifs = val)),
            _buildSwitchTile("Push Notifications", _pushNotifs, (val) => setState(() => _pushNotifs = val)),
            _buildSwitchTile("SMS Notifications", _smsNotifs, (val) => setState(() => _smsNotifs = val)),
            
            const SizedBox(height: 30),
            _buildSectionHeader("Events"),
            const SizedBox(height: 10),
            _buildSwitchTile("New Product Registrations", _registration, (val) => setState(() => _registration = val)),
            _buildSwitchTile("New Shop Applications", _newOrder, (val) => setState(() => _newOrder = val)),
            _buildSwitchTile("Payment & Order Failures", _paymentAlerts, (val) => setState(() => _paymentAlerts = val)),
            
            const SizedBox(height: 30),
            _buildSectionHeader("Templates"),
            const SizedBox(height: 15),
            _buildTemplateTile("Welcome Email Template"),
            _buildTemplateTile("Order Confirmation SMS"),
            _buildTemplateTile("Password Reset Email"),
            
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Notification preferences saved!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("Test Notifications", style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.w500)),
      value: value,
      activeColor: Colors.black,
      onChanged: onChanged,
    );
  }

  Widget _buildTemplateTile(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(title, style: GoogleFonts.outfit(fontSize: 14)),
        trailing: const Icon(Icons.code, size: 20),
        onTap: () {},
      ),
    );
  }
}
