import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderSettingsPage extends StatefulWidget {
  const OrderSettingsPage({super.key});

  @override
  State<OrderSettingsPage> createState() => _OrderSettingsPageState();
}

class _OrderSettingsPageState extends State<OrderSettingsPage> {
  bool _autoAccept = false;
  bool _allowPickup = true;
  bool _allowDelivery = true;
  final _cancelTimeController = TextEditingController(text: "30");
  final _deliveryChargeController = TextEditingController(text: "40");
  final _freeThresholdController = TextEditingController(text: "500");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Order Settings',
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
            _buildSectionHeader("Order Lifecycle"),
            const SizedBox(height: 10),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Auto-accept Orders", style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
              subtitle: Text("Automatically confirm orders upon payment", style: GoogleFonts.outfit(fontSize: 12)),
              value: _autoAccept,
              activeColor: Colors.black,
              onChanged: (val) => setState(() => _autoAccept = val),
            ),
            const Divider(),
            const SizedBox(height: 10),
            _buildNumberField("Cancellation Time Limit (Minutes)", _cancelTimeController),
            const SizedBox(height: 30),
            
            _buildSectionHeader("Delivery & Pickup"),
            const SizedBox(height: 10),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Store Pickup", style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
              value: _allowPickup,
              activeColor: Colors.black,
              onChanged: (val) => setState(() => _allowPickup = val ?? true),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Home Delivery", style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
              value: _allowDelivery,
              activeColor: Colors.black,
              onChanged: (val) => setState(() => _allowDelivery = val ?? true),
            ),
            const SizedBox(height: 15),
            _buildNumberField("Default Delivery Charge (₹)", _deliveryChargeController),
            const SizedBox(height: 15),
            _buildNumberField("Free Delivery Threshold (₹)", _freeThresholdController),
            
            const SizedBox(height: 30),
            _buildSectionHeader("Policies"),
            const SizedBox(height: 15),
            _buildPolicyItem("Return & Refund Policy"),
            _buildPolicyItem("Order Cancellation Rules"),
            
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Order settings updated successfully!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("Apply Changes", style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white)),
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

  Widget _buildPolicyItem(String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.edit_note, color: Colors.black),
      onTap: () {},
    );
  }
}
