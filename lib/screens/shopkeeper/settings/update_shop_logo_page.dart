import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UpdateShopLogoPage extends StatefulWidget {
  const UpdateShopLogoPage({super.key});

  @override
  State<UpdateShopLogoPage> createState() => _UpdateShopLogoPageState();
}

class _UpdateShopLogoPageState extends State<UpdateShopLogoPage> {
  File? _logoImage;
  final ImagePicker _picker = ImagePicker();
  bool _hasExistingLogo = true; // Simulating existing logo

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );
    
    if (pickedFile != null) {
      setState(() {
        _logoImage = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose Image Source',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.photo_library, color: Colors.blue),
                  ),
                  title: Text(
                    'Photo Library',
                    style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.photo_camera, color: Colors.green),
                  ),
                  title: Text(
                    'Camera',
                    style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _removeLogo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Remove Logo',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to remove the shop logo? A default logo will be used.',
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
                _logoImage = null;
                _hasExistingLogo = false;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Logo removed successfully',
                    style: GoogleFonts.outfit(),
                  ),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            child: Text(
              'Remove',
              style: GoogleFonts.outfit(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _saveLogo() {
    // TODO: Implement actual logo upload to backend/cloud storage
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Shop logo updated successfully!',
          style: GoogleFonts.outfit(),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Update Shop Logo',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            
            // Logo Preview
            Text(
              'Logo Preview',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),
            
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[300]!, width: 2),
              ),
              child: _logoImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.file(
                        _logoImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : _hasExistingLogo
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            color: const Color(0xFFCDB7A6),
                            child: Center(
                              child: Text(
                                'SHOP\nLOGO',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Icon(
                          Icons.store,
                          size: 80,
                          color: Colors.grey[400],
                        ),
            ),
            const SizedBox(height: 30),

            // Recommended Size Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue[700]),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Recommended size: 512x512 pixels\nFormats: JPG, PNG, WebP',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Upload/Replace Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showImageSourceDialog,
                icon: Icon(
                  _logoImage != null || _hasExistingLogo
                      ? Icons.refresh
                      : Icons.upload,
                  color: Colors.white,
                ),
                label: Text(
                  _logoImage != null || _hasExistingLogo
                      ? 'Replace Logo'
                      : 'Upload Logo',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Remove Logo Button
            if (_logoImage != null || _hasExistingLogo)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _removeLogo,
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  label: Text(
                    'Remove Logo',
                    style: GoogleFonts.outfit(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 30),

            // Save Button
            if (_logoImage != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveLogo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
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
}
