import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPreferencesPage extends StatefulWidget {
  const NotificationPreferencesPage({super.key});

  @override
  State<NotificationPreferencesPage> createState() =>
      _NotificationPreferencesPageState();
}

class _NotificationPreferencesPageState
    extends State<NotificationPreferencesPage> {
  // Notification Types
  bool _newOrderNotifs = true;
  bool _paymentConfirmation = true;
  bool _lowStockAlerts = true;
  bool _customerMessages = false;

  // Notification Channels
  bool _emailChannel = true;
  bool _pushChannel = true;
  bool _smsChannel = false;

  void _savePreferences() {
    // TODO: Save to backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              'Preferences saved successfully!',
              style: GoogleFonts.outfit(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Notification Preferences',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
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
            // Notification Types Section
            _buildSectionHeader(
              'Notification Types',
              'Choose what you want to be notified about',
            ),
            const SizedBox(height: 15),
            
            _buildNotificationTile(
              icon: Icons.shopping_bag_outlined,
              title: 'New Order Notifications',
              subtitle: 'Get notified when you receive a new order',
              value: _newOrderNotifs,
              onChanged: (val) => setState(() => _newOrderNotifs = val),
              iconColor: Colors.blue,
            ),
            
            _buildNotificationTile(
              icon: Icons.payment_outlined,
              title: 'Payment Confirmation',
              subtitle: 'Alerts when payment is confirmed',
              value: _paymentConfirmation,
              onChanged: (val) => setState(() => _paymentConfirmation = val),
              iconColor: Colors.green,
            ),
            
            _buildNotificationTile(
              icon: Icons.inventory_2_outlined,
              title: 'Low Stock Alerts',
              subtitle: 'Get notified when products are running low',
              value: _lowStockAlerts,
              onChanged: (val) => setState(() => _lowStockAlerts = val),
              iconColor: Colors.orange,
            ),
            
            _buildNotificationTile(
              icon: Icons.message_outlined,
              title: 'Customer Messages',
              subtitle: 'Notifications for customer inquiries',
              value: _customerMessages,
              onChanged: (val) => setState(() => _customerMessages = val),
              iconColor: Colors.purple,
            ),
            
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            
            // Notification Channels Section
            _buildSectionHeader(
              'Notification Channels',
              'How would you like to receive notifications?',
            ),
            const SizedBox(height: 15),
            
            _buildChannelTile(
              icon: Icons.email_outlined,
              title: 'Email Notifications',
              subtitle: 'Receive notifications via email',
              value: _emailChannel,
              onChanged: (val) => setState(() => _emailChannel = val),
              iconColor: Colors.red,
            ),
            
            _buildChannelTile(
              icon: Icons.notifications_outlined,
              title: 'Push Notifications',
              subtitle: 'Receive push notifications on your device',
              value: _pushChannel,
              onChanged: (val) => setState(() => _pushChannel = val),
              iconColor: Colors.blue,
            ),
            
            _buildChannelTile(
              icon: Icons.sms_outlined,
              title: 'SMS Notifications',
              subtitle: 'Receive notifications via text message',
              value: _smsChannel,
              onChanged: (val) => setState(() => _smsChannel = val),
              iconColor: Colors.green,
            ),
            
            const SizedBox(height: 30),
            
            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _savePreferences,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Save Preferences',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: GoogleFonts.outfit(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required Color iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        secondary: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.outfit(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.black,
      ),
    );
  }

  Widget _buildChannelTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required Color iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        secondary: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.outfit(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.black,
      ),
    );
  }
}
