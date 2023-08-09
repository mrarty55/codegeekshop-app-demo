class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.currencyUnit,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final String currencyUnit;
  final String imageUrl;

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? currencyUnit,
    String? imageUrl,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        currencyUnit: currencyUnit ?? this.currencyUnit,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory Product.fromFirestore(String id, Map<String, dynamic> json) =>
      Product(
        id: id,
        name: json['name'],
        description: json['description'],
        price: (json['price'] as int).toDouble(),
        currencyUnit: json['currencyUnit'],
        imageUrl: json['imageUrl'],
      );

  Map<String, dynamic> toFirestore() => {
        "name": name,
        "description": description,
        "price": price,
        "currencyUnit": currencyUnit,
        "imageUrl": imageUrl,
      };
}
