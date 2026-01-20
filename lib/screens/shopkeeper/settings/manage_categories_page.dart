import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Category {
  String id;
  String name;
  String description;
  bool isEnabled;
  IconData icon;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.isEnabled,
    required this.icon,
  });
}

class ManageCategoriesPage extends StatefulWidget {
  const ManageCategoriesPage({super.key});

  @override
  State<ManageCategoriesPage> createState() => _ManageCategoriesPageState();
}

class _ManageCategoriesPageState extends State<ManageCategoriesPage> {
  List<Category> categories = [
    Category(
      id: '1',
      name: 'Rice & Grains',
      description: 'All types of rice and grains',
      isEnabled: true,
      icon: Icons.rice_bowl,
    ),
    Category(
      id: '2',
      name: 'Spices',
      description: 'Spices and masalas',
      isEnabled: true,
      icon: Icons.local_fire_department,
    ),
    Category(
      id: '3',
      name: 'Oils & Ghee',
      description: 'Cooking oils and ghee',
      isEnabled: true,
      icon: Icons.water_drop,
    ),
    Category(
      id: '4',
      name: 'Pulses & Dals',
      description: 'Lentils and pulses',
      isEnabled: false,
      icon: Icons.grain,
    ),
  ];

  void _addCategory() {
    showDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController();
        final descController = TextEditingController();
        
        return AlertDialog(
          title: Text(
            'Add New Category',
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Category Name',
                  labelStyle: GoogleFonts.outfit(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: GoogleFonts.outfit(),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: GoogleFonts.outfit(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: GoogleFonts.outfit(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: GoogleFonts.outfit()),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    categories.add(
                      Category(
                        id: DateTime.now().toString(),
                        name: nameController.text,
                        description: descController.text,
                        isEnabled: true,
                        icon: Icons.category,
                      ),
                    );
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Category added successfully',
                        style: GoogleFonts.outfit(),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text('Add', style: GoogleFonts.outfit(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _editCategory(Category category) {
    final nameController = TextEditingController(text: category.name);
    final descController = TextEditingController(text: category.description);
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Edit Category',
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Category Name',
                  labelStyle: GoogleFonts.outfit(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: GoogleFonts.outfit(),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: GoogleFonts.outfit(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: GoogleFonts.outfit(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: GoogleFonts.outfit()),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  category.name = nameController.text;
                  category.description = descController.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Category updated successfully',
                      style: GoogleFonts.outfit(),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text('Save', style: GoogleFonts.outfit(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _deleteCategory(Category category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Category',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to delete "${category.name}"? This action cannot be undone.',
          style: GoogleFonts.outfit(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.outfit()),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                categories.removeWhere((c) => c.id == category.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Category deleted successfully',
                    style: GoogleFonts.outfit(),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: Text(
              'Delete',
              style: GoogleFonts.outfit(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Manage Categories',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.black),
            onPressed: _addCategory,
          ),
        ],
      ),
      body: categories.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.category_outlined, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 20),
                  Text(
                    'No categories yet',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _addCategory,
                    icon: const Icon(Icons.add),
                    label: Text('Add Category', style: GoogleFonts.outfit()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          : ReorderableListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: categories.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final item = categories.removeAt(oldIndex);
                  categories.insert(newIndex, item);
                });
              },
              itemBuilder: (context, index) {
                final category = categories[index];
                return Card(
                  key: ValueKey(category.id),
                  margin: const EdgeInsets.only(bottom: 15),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: category.isEnabled
                            ? Colors.green[50]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        category.icon,
                        color: category.isEnabled ? Colors.green : Colors.grey,
                      ),
                    ),
                    title: Text(
                      category.name,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.description,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: category.isEnabled
                                ? Colors.green[100]
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            category.isEnabled ? 'Enabled' : 'Disabled',
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: category.isEnabled
                                  ? Colors.green[800]
                                  : Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: category.isEnabled,
                          onChanged: (value) {
                            setState(() {
                              category.isEnabled = value;
                            });
                          },
                          activeColor: Colors.green,
                        ),
                        PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  const Icon(Icons.edit, size: 20),
                                  const SizedBox(width: 10),
                                  Text('Edit', style: GoogleFonts.outfit()),
                                ],
                              ),
                              onTap: () {
                                Future.delayed(
                                  Duration.zero,
                                  () => _editCategory(category),
                                );
                              },
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  const Icon(Icons.delete, size: 20, color: Colors.red),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Delete',
                                    style: GoogleFonts.outfit(color: Colors.red),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Future.delayed(
                                  Duration.zero,
                                  () => _deleteCategory(category),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: categories.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _addCategory,
              backgroundColor: Colors.black,
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text(
                'Add Category',
                style: GoogleFonts.outfit(color: Colors.white),
              ),
            )
          : null,
    );
  }
}
