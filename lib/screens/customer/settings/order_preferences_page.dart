import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderPreferencesPage extends StatefulWidget {
  const OrderPreferencesPage({super.key});

  @override
  State<OrderPreferencesPage> createState() => _OrderPreferencesPageState();
}

class _OrderPreferencesPageState extends State<OrderPreferencesPage> {
  String _communicationPref = 'Email';
  bool _ecoFriendly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Order Preferences',
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
            _buildSectionHeader("Delivery"),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.location_on_outlined, color: Colors.black),
              title: Text("Preferred Delivery Address", style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
              subtitle: Text("104/G, Boobalarayerpuram...", style: GoogleFonts.outfit(color: Colors.grey)),
              trailing: TextButton(onPressed: () {}, child: const Text("Edit")),
            ),
            
            const SizedBox(height: 20),
            
            _buildSectionHeader("Payment"),
             ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.credit_card_outlined, color: Colors.black),
              title: Text("Default Payment Method", style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
              subtitle: Text("xxxx-xxxx-xxxx-4242", style: GoogleFonts.outfit(color: Colors.grey)),
              trailing: TextButton(onPressed: () {}, child: const Text("Change")),
            ),
            
            const SizedBox(height: 20),
            
            _buildSectionHeader("Communication"),
             Text("How should we contact you about orders?", style: GoogleFonts.outfit(color: Colors.grey[600])),
             const SizedBox(height: 10),
             Wrap(
               spacing: 10,
               children: [
                 _buildChoiceChip("Email", _communicationPref == 'Email'),
                 _buildChoiceChip("SMS", _communicationPref == 'SMS'),
                 _buildChoiceChip("Push Notification", _communicationPref == 'Push'),
               ],
             ),
             
            const SizedBox(height: 30),
            
            _buildSectionHeader("Other Preferences"),
             SwitchListTile(
               contentPadding: EdgeInsets.zero,
               activeColor: Colors.black,
               title: Text("Eco-friendly packaging", style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
               subtitle: Text("Use minimal plastic and recycled materials", style: GoogleFonts.outfit(fontSize: 12)),
               value: _ecoFriendly,
               onChanged: (val) => setState(() => _ecoFriendly = val),
             )
          ],
        ),
      ),
    );
  }
  
  Widget _buildChoiceChip(String label, bool selected) {
    return ChoiceChip(
      label: Text(label, style: GoogleFonts.outfit(
        color: selected ? Colors.white : Colors.black
      )),
      selected: selected,
      selectedColor: Colors.black,
      backgroundColor: Colors.grey[200],
      onSelected: (bool selected) {
        if (selected) {
          setState(() {
            _communicationPref = label;
          });
        }
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}
