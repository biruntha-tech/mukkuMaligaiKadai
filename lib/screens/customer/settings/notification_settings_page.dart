import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _emailNotifs = true;
  bool _pushNotifs = true;
  bool _smsNotifs = false;
  
  bool _orderUpdates = true;
  bool _promos = false;
  bool _accountAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Notification Settings',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
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
            _buildSwitchTile("Email Notifications", _emailNotifs, (val) => setState(() => _emailNotifs = val)),
            _buildSwitchTile("Push Notifications", _pushNotifs, (val) => setState(() => _pushNotifs = val)),
            _buildSwitchTile("SMS Notifications", _smsNotifs, (val) => setState(() => _smsNotifs = val)),
            
            const Divider(height: 40),
            
            _buildSectionHeader("Notification Types"),
            _buildSwitchTile("Order Updates", _orderUpdates, (val) => setState(() => _orderUpdates = val)),
            _buildSwitchTile("Promotional Offers", _promos, (val) => setState(() => _promos = val)),
            _buildSwitchTile("Account & Security Alerts", _accountAlerts, (val) => setState(() => _accountAlerts = val)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SwitchListTile(
        activeColor: Colors.black,
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
