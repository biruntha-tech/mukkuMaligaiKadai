import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageAccountPage extends StatefulWidget {
  const ManageAccountPage({super.key});

  @override
  State<ManageAccountPage> createState() => _ManageAccountPageState();
}

class _ManageAccountPageState extends State<ManageAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Manage Account',
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
            _buildSectionHeader("Security"),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.lock_outline, color: Colors.black),
              ),
              title: Text("Change Password", style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to change password
              },
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.email_outlined, color: Colors.black),
              ),
              title: Text("Update Email Address", style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to update email
              },
            ),
             const Divider(),
             const SizedBox(height: 20),
             
             _buildSectionHeader("Login Activity"),
             const SizedBox(height: 10),
             Container(
               padding: const EdgeInsets.all(16),
               decoration: BoxDecoration(
                 color: Colors.grey[50], 
                 borderRadius: BorderRadius.circular(12),
                 border: Border.all(color: Colors.grey[300]!)
               ),
               child: Row(
                 children: [
                   const Icon(Icons.phone_android, color: Colors.grey),
                   const SizedBox(width: 15),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Current Device (OnePlus 9)", style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
                       Text("Last active: Just now", style: GoogleFonts.outfit(color: Colors.grey, fontSize: 12)),
                     ],
                   )
                 ],
               ),
             ),
             
             const SizedBox(height: 40),
             
             _buildSectionHeader("Danger Zone"),
             const SizedBox(height: 10),
             
             OutlinedButton.icon(
              onPressed: () {
                // Show delete confirmation
              },
              icon: const Icon(Icons.logout, color: Colors.blue),
              label: Text("Log out from all devices", style: GoogleFonts.outfit(color: Colors.blue)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue),
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.centerLeft
              ),
            ),
             const SizedBox(height: 10),
             OutlinedButton.icon(
               onPressed: () {
                 // Show delete confirmation
               },
               icon: const Icon(Icons.delete_outline, color: Colors.red),
               label: Text("Delete Account", style: GoogleFonts.outfit(color: Colors.red)),
               style: OutlinedButton.styleFrom(
                 side: const BorderSide(color: Colors.red),
                 padding: const EdgeInsets.symmetric(vertical: 12),
                 alignment: Alignment.centerLeft
               ),
             )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.grey[600],
      ),
    );
  }
}
