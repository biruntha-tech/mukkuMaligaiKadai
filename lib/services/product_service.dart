import '../models/product.dart';

class ProductService {
  static final ProductService _instance = ProductService._internal();
  factory ProductService() => _instance;
  ProductService._internal();

  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Pampers\npants (L)',
      subtitle: 'pack of 52 pcs',
      priceValue: 845.0,
      price: '₹ 845',
      stocks: 14,
      category: 'Baby Care',
      imagePath: 'assets/pampers.png',
    ),
    Product(
      id: '2',
      name: 'Dairy milk\nchocolate',
      subtitle: '',
      priceValue: 30.0,
      price: '₹ 30',
      stocks: 24,
      category: 'Chocolates',
      imagePath: 'assets/dairymilk.png',
    ),
    Product(
      id: '3',
      name: 'Fresh Banana',
      subtitle: '1 kg',
      priceValue: 40.0,
      price: '₹ 40',
      stocks: 3, // Low stock example
      category: 'Fruits',
      imagePath: null,
    ),
  ];

  List<Product> get products => List.unmodifiable(_products);

  void addProduct(Product product) {
    _products.add(product);
  }

  void updateProduct(String id, Product updatedProduct) {
    final index = _products.indexWhere((p) => p.id == id);
    if (index != -1) {
      _products[index] = updatedProduct;
    }
  }

  void deleteProduct(String id) {
    final index = _products.indexWhere((p) => p.id == id);
    if (index != -1) {
      _products[index].isDeleted = true;
    }
  }

  void hideProduct(String id) {
    final index = _products.indexWhere((p) => p.id == id);
    if (index != -1) {
      _products[index].isHidden = true;
    }
  }

  void restoreProduct(String id) {
    final index = _products.indexWhere((p) => p.id == id);
    if (index != -1) {
      _products[index].isDeleted = false;
      _products[index].isHidden = false;
    }
  }
}
