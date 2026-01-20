import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlatformSettingsPage extends StatefulWidget {
  const PlatformSettingsPage({super.key});

  @override
  State<PlatformSettingsPage> createState() => _PlatformSettingsPageState();
}

class _PlatformSettingsPageState extends State<PlatformSettingsPage> {
  final _platformNameController = TextEditingController(text: "Mukku Maligai Kadai");
  bool _maintenanceMode = false;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'INR (₹)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Platform Settings',
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
            _buildSectionHeader("Branding"),
            const SizedBox(height: 20),
            _buildTextField("Platform Name", _platformNameController),
            const SizedBox(height: 20),
            Text("Platform Logo", style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const Icon(Icons.storefront, size: 40, color: Colors.grey),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("Upload New Logo", style: GoogleFonts.outfit(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildSectionHeader("Localization"),
            const SizedBox(height: 15),
            _buildDropdown("Default Language", _selectedLanguage, ['English', 'Tamil', 'Hindi'], (val) => setState(() => _selectedLanguage = val!)),
            const SizedBox(height: 15),
            _buildDropdown("Currency Settings", _selectedCurrency, ['INR (₹)', 'USD (\$)', 'EUR (€)'], (val) => setState(() => _selectedCurrency = val!)),
            
            const SizedBox(height: 30),
            _buildSectionHeader("System Status"),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _maintenanceMode ? Colors.red[50] : Colors.grey[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: _maintenanceMode ? Colors.red[200]! : Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Maintenance Mode", style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
                    subtitle: Text("Take the entire platform offline for maintenance", style: GoogleFonts.outfit(fontSize: 12)),
                    value: _maintenanceMode,
                    activeColor: Colors.red,
                    onChanged: (val) => setState(() => _maintenanceMode = val),
                  ),
                  if (_maintenanceMode) ...[
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter custom maintenance message",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: GoogleFonts.outfit(fontSize: 14),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Platform settings saved successfully!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("Save Settings", style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white)),
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          style: GoogleFonts.outfit(),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, Function(String?) onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.outfit()))).toList(),
              onChanged: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
