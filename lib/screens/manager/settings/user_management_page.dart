import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SystemUser {
  final String id;
  final String name;
  final String email;
  final String role;
  bool isActive;

  SystemUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.isActive = true,
  });
}

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final List<SystemUser> _users = [
    SystemUser(id: "1", name: "Jose Milton", email: "jose@gmail.com", role: "Super Admin"),
    SystemUser(id: "2", name: "Shiva Kumar", email: "shiva@shop.com", role: "Shop Owner"),
    SystemUser(id: "3", name: "Mariappan", email: "mari@staff.com", role: "Staff"),
    SystemUser(id: "4", name: "Dinesh", email: "dinesh@customer.com", role: "Customer"),
    SystemUser(id: "5", name: "Arun", email: "arun@customer.com", role: "Customer", isActive: false),
  ];

  String _searchQuery = "";
  String _selectedRole = "All";
  final List<String> _roles = ["All", "Super Admin", "Admin", "Shop Owner", "Staff", "Customer"];

  @override
  Widget build(BuildContext context) {
    List<SystemUser> filteredUsers = _users.where((user) {
      final matchesSearch = user.name.toLowerCase().contains(_searchQuery.toLowerCase()) || 
                           user.email.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesRole = _selectedRole == "All" || user.role == _selectedRole;
      return matchesSearch && matchesRole;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'User Management',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1, color: Colors.black),
            onPressed: () {
              // Add user logic
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: "Search by name or email...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  style: GoogleFonts.outfit(),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _roles.map((role) {
                      bool isSelected = _selectedRole == role;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(role, style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: isSelected ? Colors.white : Colors.black,
                          )),
                          selected: isSelected,
                          selectedColor: Colors.black,
                          onSelected: (val) {
                            if (val) setState(() => _selectedRole = role);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return _buildUserTile(user);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTile(SystemUser user) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            child: Text(user.name[0], style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
                Text(user.email, style: GoogleFonts.outfit(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(user.role, style: GoogleFonts.outfit(fontSize: 10, color: Colors.blue[800], fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Switch(
                value: user.isActive,
                onChanged: (val) => setState(() => user.isActive = val),
                activeColor: Colors.green,
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert, size: 20),
                itemBuilder: (context) => [
                  _buildPopupItem(Icons.edit, "Edit Role"),
                  _buildPopupItem(Icons.lock_reset, "Reset Password"),
                  _buildPopupItem(Icons.history, "Activity Logs"),
                  _buildPopupItem(Icons.delete_outline, "Delete User", color: Colors.red),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem _buildPopupItem(IconData icon, String title, {Color? color}) {
    return PopupMenuItem(
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Text(title, style: GoogleFonts.outfit(fontSize: 14, color: color)),
        ],
      ),
    );
  }
}
