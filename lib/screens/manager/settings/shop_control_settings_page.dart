import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopControlSettingsPage extends StatefulWidget {
  const ShopControlSettingsPage({super.key});

  @override
  State<ShopControlSettingsPage> createState() => _ShopControlSettingsPageState();
}

class _ShopControlSettingsPageState extends State<ShopControlSettingsPage> {
  bool _autoApprove = false;
  final _commissionController = TextEditingController(text: "10");
  final _maxProductsController = TextEditingController(text: "500");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Shop Control',
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
            _buildSectionHeader("Approval Workflow"),
            const SizedBox(height: 10),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Auto-approve New Shops", style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
              subtitle: Text("Shops skip the manual verification process", style: GoogleFonts.outfit(fontSize: 12)),
              value: _autoApprove,
              activeColor: Colors.black,
              onChanged: (val) => setState(() => _autoApprove = val),
            ),
            const SizedBox(height: 30),
            
            _buildSectionHeader("Fees & Commissions"),
            const SizedBox(height: 15),
            _buildNumberField("Default Commission Percentage (%)", _commissionController),
            const SizedBox(height: 30),
            
            _buildSectionHeader("Shop Limits"),
            const SizedBox(height: 15),
            _buildNumberField("Max Products per Shop", _maxProductsController),
            const SizedBox(height: 30),
            
            _buildSectionHeader("Emergency Controls"),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.red[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Suspend All Shops", style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.red)),
                  const SizedBox(height: 8),
                  Text("Use this in case of platform-wide emergencies to prevent new orders.", style: GoogleFonts.outfit(fontSize: 12, color: Colors.red[700])),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showEmergencyDialog();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text("Emergency Suspension", style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Shop control settings updated!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("Save Configuration", style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white)),
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

  Widget _buildNumberField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          style: GoogleFonts.outfit(),
        ),
      ],
    );
  }

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Suspension", style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: Text("This will immediately disable ordering across ALL shops. This action is logged.", style: GoogleFonts.outfit()),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel", style: GoogleFonts.outfit())),
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Yes, Suspend", style: GoogleFonts.outfit(color: Colors.red))),
        ],
      ),
    );
  }
}
