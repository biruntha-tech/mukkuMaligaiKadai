class Product {
  final String id;
  String name;
  String subtitle;
  double priceValue;
  String price; // Display string e.g. "₹ 30"
  int stocks;
  String category;
  String? imagePath;
  bool isDeleted;
  bool isHidden;
  bool isEdited;

  Product({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.priceValue,
    required this.price,
    required this.stocks,
    required this.category,
    this.imagePath,
    this.isDeleted = false,
    this.isHidden = false,
    this.isEdited = false,
  });

  Product copyWith({
    String? name,
    String? subtitle,
    double? priceValue,
    String? price,
    int? stocks,
    String? category,
    String? imagePath,
    bool? isDeleted,
    bool? isHidden,
    bool? isEdited,
  }) {
    return Product(
      id: this.id,
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      priceValue: priceValue ?? this.priceValue,
      price: price ?? this.price,
      stocks: stocks ?? this.stocks,
      category: category ?? this.category,
      imagePath: imagePath ?? this.imagePath,
      isDeleted: isDeleted ?? this.isDeleted,
      isHidden: isHidden ?? this.isHidden,
      isEdited: isEdited ?? this.isEdited,
    );
  }
}
