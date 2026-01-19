import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_product_page.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';

enum ProductFilter { all, deleted, edited, hidden }
enum PriceSort { none, lowToHigh, highToLow }

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  static const Color brandColor = Colors.white;
  static const Color bgColor = Color(0xFFCDB7A6);
  static const Color cardColor = Color(0x99FFFFFF); // Colors.white.withOpacity(0.6)

  ProductFilter _currentFilter = ProductFilter.all;
  PriceSort _priceSort = PriceSort.none;
  String? _selectedCategory;
  bool _onlyAvailable = false;
  bool _onlyLowStock = false;
  bool _showAll = false;

  final Set<String> _editingIds = {};
  final Map<String, TextEditingController> _nameControllers = {};
  final Map<String, TextEditingController> _priceControllers = {};
  final Map<String, TextEditingController> _stockControllers = {};
  final Set<String> _selectedForRestore = {};

  @override
  void dispose() {
    for (var c in _nameControllers.values) c.dispose();
    for (var c in _priceControllers.values) c.dispose();
    for (var c in _stockControllers.values) c.dispose();
    super.dispose();
  }

  void _startEditing(Product product) {
    setState(() {
      _editingIds.add(product.id);
      _nameControllers[product.id] = TextEditingController(text: product.name);
      _priceControllers[product.id] = TextEditingController(text: product.price);
      _stockControllers[product.id] = TextEditingController(text: product.stocks.toString());
    });
  }

  void _saveEdit(Product product) {
    final priceStr = _priceControllers[product.id]!.text;
    final cleanPrice = priceStr.replaceAll(RegExp(r'[^0-9.]'), '');
    final priceVal = double.tryParse(cleanPrice) ?? 0.0;
    
    final updatedProduct = product.copyWith(
      name: _nameControllers[product.id]!.text,
      price: priceStr.startsWith('₹') ? priceStr : '₹ $priceStr',
      priceValue: priceVal,
      stocks: int.tryParse(_stockControllers[product.id]!.text) ?? 0,
      isEdited: true,
    );
    
    ProductService().updateProduct(product.id, updatedProduct);
    
    setState(() {
      _editingIds.remove(product.id);
      _nameControllers.remove(product.id)?.dispose();
      _priceControllers.remove(product.id)?.dispose();
      _stockControllers.remove(product.id)?.dispose();
    });
  }

  List<Product> _getFilteredProducts() {
    final allProducts = ProductService().products;
    List<Product> filtered;

    // First, apply the status filter (All, Deleted, etc)
    switch (_currentFilter) {
      case ProductFilter.deleted:
        filtered = allProducts.where((p) => p.isDeleted).toList();
        break;
      case ProductFilter.edited:
        filtered = allProducts.where((p) => p.isEdited && !p.isDeleted).toList();
        break;
      case ProductFilter.hidden:
        filtered = allProducts.where((p) => p.isHidden && !p.isDeleted).toList();
        break;
      case ProductFilter.all:
      default:
        filtered = allProducts.where((p) => !p.isDeleted && !p.isHidden).toList();
        break;
    }

    // Apply Category filter
    if (_selectedCategory != null) {
      filtered = filtered.where((p) => p.category == _selectedCategory).toList();
    }

    // Apply Availability filter
    if (_onlyAvailable) {
      filtered = filtered.where((p) => p.stocks > 0).toList();
    }

    // Apply Low Stock filter
    if (_onlyLowStock) {
      filtered = filtered.where((p) => p.stocks > 0 && p.stocks <= 5).toList();
    }

    // Apply Price Sorting
    if (_priceSort == PriceSort.lowToHigh) {
      filtered.sort((a, b) => a.priceValue.compareTo(b.priceValue));
    } else if (_priceSort == PriceSort.highToLow) {
      filtered.sort((a, b) => b.priceValue.compareTo(a.priceValue));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _getFilteredProducts();
    final displayedProducts = _showAll ? filteredProducts : (filteredProducts.length > 2 ? filteredProducts.sublist(0, 2) : filteredProducts);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          _AppBarTitle(),
          style: GoogleFonts.outfit(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<ProductFilter>(
            icon: const Icon(Icons.menu, color: Colors.black, size: 30),
            onSelected: (filter) => setState(() => _currentFilter = filter),
            itemBuilder: (context) => [
              const PopupMenuItem(value: ProductFilter.all, child: Text("ALL PRODUCTS")),
              const PopupMenuItem(value: ProductFilter.deleted, child: Text("DELETE")),
              const PopupMenuItem(value: ProductFilter.edited, child: Text("EDIT")),
              const PopupMenuItem(value: ProductFilter.hidden, child: Text("HIDE")),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            if (_currentFilter == ProductFilter.deleted && _selectedForRestore.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton.icon(
                  onPressed: _restoreSelectedItems,
                  icon: const Icon(Icons.restore),
                  label: Text('RESTORE ${_selectedForRestore.length} ITEM(S)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6B584F),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
            ],
            if (_currentFilter == ProductFilter.all) ...[
              _buildSearchBox(),
              const SizedBox(height: 20),
              _buildFilterBar(),
              const SizedBox(height: 20),
            ],
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  ...displayedProducts.map((p) => Column(
                    children: [
                      _buildProductCard(p),
                      const SizedBox(height: 20),
                    ],
                  )),
                  
                  if (!_showAll && filteredProducts.length > 2)
                    _buildExpandArrow(),

                  if (_currentFilter == ProductFilter.all)
                    _buildAddProductButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _AppBarTitle() {
    switch (_currentFilter) {
      case ProductFilter.deleted: return "Deleted Items";
      case ProductFilter.edited: return "Edited Items";
      case ProductFilter.hidden: return "Hidden Items";
      default: return "Products";
    }
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: brandColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search Products',
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.search, size: 30, color: Colors.white),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          _buildFilterChip('Category', 
            isActive: _selectedCategory != null,
            onTap: _showCategoryPicker),
          _buildFilterChip('Price', 
            isActive: _priceSort != PriceSort.none,
            onTap: _togglePriceSort),
          _buildFilterChip('Availability', 
            isActive: _onlyAvailable,
            onTap: () => setState(() => _onlyAvailable = !_onlyAvailable)),
          _buildFilterChip('Low Stock', 
            isActive: _onlyLowStock,
            onTap: () => setState(() => _onlyLowStock = !_onlyLowStock)),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {required bool isActive, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? brandColor.withOpacity(0.4) : cardColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: isActive ? brandColor : brandColor.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isActive) ...[
              const SizedBox(width: 5),
              const Icon(Icons.close, size: 14),
            ]
          ],
        ),
      ),
    );
  }

  void _showCategoryPicker() {
    final categories = ProductService().products.map((p) => p.category).toSet().toList();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: const Text("All Categories"),
            onTap: () {
              setState(() => _selectedCategory = null);
              Navigator.pop(context);
            },
          ),
          ...categories.map((cat) => ListTile(
            title: Text(cat),
            onTap: () {
              setState(() => _selectedCategory = cat);
              Navigator.pop(context);
            },
          )),
        ],
      ),
    );
  }

  void _togglePriceSort() {
    setState(() {
      if (_priceSort == PriceSort.none) _priceSort = PriceSort.lowToHigh;
      else if (_priceSort == PriceSort.lowToHigh) _priceSort = PriceSort.highToLow;
      else _priceSort = PriceSort.none;
    });
  }

  Widget _buildProductCard(Product product) {
    bool isEditing = _editingIds.contains(product.id);
    bool isDeleted = _currentFilter == ProductFilter.deleted;
    bool isSelected = _selectedForRestore.contains(product.id);

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(25),
        border: isDeleted && isSelected ? Border.all(color: Colors.white, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: brandColor.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: isEditing 
        ? _buildEditForm(product)
        : Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDeleted) ...[
            GestureDetector(
              onTap: () => _toggleSelection(product.id),
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                  color: isSelected ? Colors.white : Colors.grey,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
          _buildProductThumbnail(product.imagePath),
          const SizedBox(width: 15),
          _buildProductDetails(product),
        ],
      ),
    );
  }

  Widget _buildProductThumbnail(String? imagePath) {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: imagePath == null ? const Icon(Icons.image, size: 50, color: Colors.grey) :
               imagePath.startsWith('assets/') ? Image.asset(imagePath, fit: BoxFit.contain) :
               Image.file(File(imagePath), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildProductDetails(Product product) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.name, style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, height: 1.1)),
          if (product.subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(product.subtitle, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          const SizedBox(height: 4),
          Text(product.price, style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          Text('Stocks : ${product.stocks}', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildActionRow(product),
        ],
      ),
    );
  }

  Widget _buildActionRow(Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildActionIcon(Icons.edit, brandColor.withOpacity(0.2), onTap: () => _startEditing(product)),
        const SizedBox(width: 8),
        _buildActionIcon(Icons.delete_outline, brandColor.withOpacity(0.1), onTap: () {
          setState(() => ProductService().deleteProduct(product.id));
        }),
        const SizedBox(width: 8),
        _buildActionIcon(Icons.visibility_off_outlined, brandColor.withOpacity(0.1), onTap: () {
          setState(() => ProductService().hideProduct(product.id));
        }),
      ],
    );
  }

  Widget _buildEditForm(Product product) {
    return Column(
      children: [
        _buildInlineField("Product Name", _nameControllers[product.id]!),
        _buildInlineField("Price (₹)", _priceControllers[product.id]!),
        _buildInlineField("Stocks", _stockControllers[product.id]!, keyboardType: TextInputType.number),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => setState(() => _editingIds.remove(product.id)),
              child: Text("CANCEL", style: GoogleFonts.outfit(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => _saveEdit(product),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: Text("SAVE", style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: const Color(0xFF6B584F))),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildInlineField(String label, TextEditingController controller, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.outfit(fontSize: 14),
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildExpandArrow() {
    return GestureDetector(
      onTap: () => setState(() => _showAll = true),
      child: const Column(
        children: [
          Icon(Icons.keyboard_arrow_down, size: 40, color: Colors.white),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildAddProductButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductPage()))
          .then((_) => setState(() {}));
      },
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: brandColor.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle_outline, size: 40, color: Colors.white),
            const SizedBox(width: 10),
            Text('ADD NEW PRODUCT', style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
        child: Icon(icon, size: 24, color: Colors.white),
      ),
    );
  }

  void _toggleSelection(String productId) {
    setState(() {
      if (_selectedForRestore.contains(productId)) {
        _selectedForRestore.remove(productId);
      } else {
        _selectedForRestore.add(productId);
      }
    });
  }

  void _restoreSelectedItems() {
    for (var productId in _selectedForRestore) {
      ProductService().restoreProduct(productId);
    }
    setState(() {
      _selectedForRestore.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Selected items restored successfully')),
    );
  }
}
