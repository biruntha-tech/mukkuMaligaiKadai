import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateShopStatusPage extends StatefulWidget {
  const UpdateShopStatusPage({super.key});

  @override
  State<UpdateShopStatusPage> createState() => _UpdateShopStatusPageState();
}

class _UpdateShopStatusPageState extends State<UpdateShopStatusPage> {
  bool _isShopOpen = true;
  String _closureReason = '';
  TimeOfDay? _scheduledOpenTime;
  TimeOfDay? _scheduledCloseTime;

  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, bool isOpenTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isOpenTime) {
          _scheduledOpenTime = picked;
        } else {
          _scheduledCloseTime = picked;
        }
      });
    }
  }

  void _updateShopStatus() {
    // TODO: Update shop status in backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              _isShopOpen ? Icons.check_circle : Icons.info,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _isShopOpen
                    ? 'Shop is now OPEN for orders'
                    : 'Shop is now CLOSED. Customers cannot place orders.',
                style: GoogleFonts.outfit(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: _isShopOpen ? Colors.green : Colors.orange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Update Shop Status',
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
            // Current Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _isShopOpen
                      ? [Colors.green[400]!, Colors.green[600]!]
                      : [Colors.orange[400]!, Colors.orange[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: (_isShopOpen ? Colors.green : Colors.orange)
                        .withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    _isShopOpen ? Icons.store : Icons.store_mall_directory_outlined,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Shop is currently',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _isShopOpen ? 'OPEN' : 'CLOSED',
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Shop Status Toggle
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shop Availability',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _isShopOpen
                              ? 'Customers can place orders'
                              : 'Orders are disabled',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _isShopOpen,
                    onChanged: (value) {
                      setState(() {
                        _isShopOpen = value;
                        if (value) {
                          _reasonController.clear();
                          _closureReason = '';
                        }
                      });
                      _updateShopStatus();
                    },
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.orange,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Closure Reason (only shown when closed)
            if (!_isShopOpen) ...[
              Text(
                'Reason for Closure (Optional)',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'e.g., On vacation, Emergency, Maintenance...',
                  hintStyle: GoogleFonts.outfit(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                style: GoogleFonts.outfit(),
                onChanged: (value) {
                  setState(() {
                    _closureReason = value;
                  });
                },
              ),
              const SizedBox(height: 20),
            ],

            // Scheduled Times Section
            const Divider(),
            const SizedBox(height: 20),
            Text(
              'Scheduled Operating Hours (Optional)',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Set automatic open and close times',
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 15),

            // Open Time
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.wb_sunny, color: Colors.green),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Opening Time',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          _scheduledOpenTime != null
                              ? _scheduledOpenTime!.format(context)
                              : 'Not set',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectTime(context, true),
                    child: Text(
                      'Set',
                      style: GoogleFonts.outfit(
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Close Time
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange[200]!),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.nightlight_round, color: Colors.orange),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Closing Time',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          _scheduledCloseTime != null
                              ? _scheduledCloseTime!.format(context)
                              : 'Not set',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectTime(context, false),
                    child: Text(
                      'Set',
                      style: GoogleFonts.outfit(
                        color: Colors.orange[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Info Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Colors.blue[700]),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'When shop is closed, customers will see a message and cannot place new orders. Existing orders can still be processed.',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
