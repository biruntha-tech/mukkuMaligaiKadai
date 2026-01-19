import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/order_model.dart';
import 'services/order_service.dart';

class OrderDetailsPage extends StatefulWidget {
  final OrderModel order;
  const OrderDetailsPage({super.key, required this.order});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  static const Color brandColor = Color(0xFF00FF80);
  static const Color bgColor = Color(0xFFE0FFF0);
  static const Color cardColor = Color(0xB3E6E1F9);

  late OrderModel _currentOrder;
  bool _isEditing = false;
  final Set<String> _selectedItems = {};

  @override
  void initState() {
    super.initState();
    _currentOrder = widget.order;
  }

  void _onAccept() {
    OrderService().acceptOrder(_currentOrder.orderId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order Accepted! Moved to Processing.')),
    );
    Navigator.pop(context);
  }

  void _onReject() {
    OrderService().rejectOrder(_currentOrder.orderId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order Rejected! Moved to Cancelled.')),
    );
    Navigator.pop(context);
  }

  void _onDeleteSelected() {
    setState(() {
      _currentOrder.items.removeWhere((item) => _selectedItems.contains(item.id));
      _selectedItems.clear();
      OrderService().updateOrder(_currentOrder);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: brandColor.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'ORDER DETAILS',
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildInfoRow('ORDER ID', _currentOrder.orderId),
                    _buildInfoRow('NAME', _currentOrder.customerName),
                    _buildInfoRow('PAYMENT', _currentOrder.paymentMethod),
                    _buildInfoRow('DATE', _currentOrder.date),
                    _buildInfoRow('TIME', _currentOrder.time),
                    const SizedBox(height: 40),
                    // Items Header
                    Row(
                      children: [
                        if (_isEditing) const SizedBox(width: 30),
                        const _TableHeaderText('S.NO'),
                        const SizedBox(width: 10),
                        const Expanded(child: _TableHeaderText('PRODUCT')),
                        const _TableHeaderText('QUANTITY'),
                        const SizedBox(width: 20),
                        const _TableHeaderText('PRICE'),
                      ],
                    ),
                    const Divider(color: Colors.black12, height: 25),
                    ..._currentOrder.items.asMap().entries.map((entry) {
                      int idx = entry.key;
                      OrderItem item = entry.value;
                      return _buildTableItem(
                        (idx + 1).toString(),
                        item,
                      );
                    }).toList(),
                    if (_isEditing && _selectedItems.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: _onDeleteSelected,
                            icon: const Icon(Icons.delete, color: Colors.red),
                            label: const Text('Delete Selected', style: TextStyle(color: Colors.red)),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'TOTAL',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(width: 40),
                          Text(
                            '₹ ${_currentOrder.totalAmount.toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF007A3D)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton('ACCEPT', brandColor.withOpacity(0.1), const Color(0xFF007A3D), onTap: _onAccept),
                  _buildActionButton('REJECT', Colors.red[50]!, Colors.red[700]!, onTap: _onReject),
                  _buildActionButton(
                    _isEditing ? 'SAVE' : 'EDIT',
                    Colors.blue[50]!,
                    Colors.blue[700]!,
                    onTap: () {
                      setState(() {
                        if (_isEditing) {
                          OrderService().updateOrder(_currentOrder);
                          _selectedItems.clear();
                        }
                        _isEditing = !_isEditing;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildTableItem(String sno, OrderItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          if (_isEditing)
            SizedBox(
              width: 30,
              height: 24,
              child: Checkbox(
                value: _selectedItems.contains(item.id),
                onChanged: (val) {
                  setState(() {
                    if (val == true) {
                      _selectedItems.add(item.id);
                    } else {
                      _selectedItems.remove(item.id);
                    }
                  });
                },
              ),
            ),
          SizedBox(width: 30, child: Text(sno, style: const TextStyle(fontWeight: FontWeight.w500))),
          Expanded(child: Text(item.productName, style: const TextStyle(fontWeight: FontWeight.bold))),
          SizedBox(width: 80, child: Text(item.quantity, style: const TextStyle(fontWeight: FontWeight.w500))),
          SizedBox(width: 60, child: Text('₹ ${item.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF007A3D)))),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, Color bgColor, Color textColor, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: textColor.withOpacity(0.2)),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _TableHeaderText extends StatelessWidget {
  final String text;
  const _TableHeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.outfit(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF007A3D),
      ),
    );
  }
}
