// product_model.dart
class Product {
  final String id;
  final String name;
  final double price;
  final double strikePrice;
  final List<String> images;
  final String description;
  final List<Map<String, dynamic>> specification;
  final List<Variant> variants;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.strikePrice,
    required this.images,
    required this.description,
    required this.specification,
    required this.variants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      strikePrice: json['strike_price'].toDouble(),
      images: List<String>.from(json['image'].map((img) => img['path'])),
      description: json['description'],
      specification: List<Map<String, dynamic>>.from(json['specification']),
      variants: List<Variant>.from(
          json['variant_details'].map((v) => Variant.fromJson(v))),
    );
  }
}

class Variant {
  final String id;
  final double price;
  final int stock;
  final List<VariantOption> options;

  Variant({
    required this.id,
    required this.price,
    required this.stock,
    required this.options,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'],
      price: json['price'].toDouble(),
      stock: json['stock'],
      options: List<VariantOption>.from(
          json['variants'].map((v) => VariantOption.fromJson(v))),
    );
  }
}

class VariantOption {
  final String type;
  final String value;

  VariantOption({required this.type, required this.value});

  factory VariantOption.fromJson(Map<String, dynamic> json) {
    return VariantOption(
      type: json['type_data']['name'],
      value: json['value_data']['name'],
    );
  }
}
