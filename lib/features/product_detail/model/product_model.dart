class Image {
  final String id;
  final String? title;
  final String path;

  Image({
    required this.id,
    this.title,
    required this.path,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      title: json['title'],
      path: json['path'],
    );
  }
}

class Product {
  final int? stock;
  final int? initialStock;
  final String id;
  final String slug;
  final String name;
  final int price;
  final int strikePrice;
  final int minOrder;
  final int maxOrder;
  final String category;
  final String categoryName;
  final String description;
  final List<Specification> specification;
  final List<Variant> variants;
  final List<VariantDetail> variantDetails;
  final List<Image> image;
  final VendorDetail vendorDetail;
  final int viewCount;
  final bool isFavourite;
  final bool commissionStatus;
  final String commissionType;
  final String commissionAmount;
  final double averageRating;
  final bool isApproved;
  final bool isFeatured;
  final bool isPublished;

  Product({
    required this.stock,
    required this.initialStock,
    required this.id,
    required this.slug,
    required this.name,
    required this.price,
    required this.strikePrice,
    required this.minOrder,
    required this.maxOrder,
    required this.category,
    required this.categoryName,
    required this.description,
    required this.specification,
    required this.variants,
    required this.variantDetails,
    required this.image,
    required this.vendorDetail,
    required this.viewCount,
    required this.isFavourite,
    required this.commissionStatus,
    required this.commissionType,
    required this.commissionAmount,
    required this.averageRating,
    required this.isApproved,
    required this.isFeatured,
    required this.isPublished,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      stock: json['stock'],
      initialStock: json['initial_stock'],
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      price: json['price'],
      strikePrice: json['strike_price'],
      minOrder: json['min_order'],
      maxOrder: json['max_order'],
      category: json['category'],
      categoryName: json['category_name'],
      description: json['description'],
      specification: (json['specification'] as List)
          .map((item) => Specification.fromJson(item))
          .toList(),
      variants: (json['variants'] as List)
          .map((item) => Variant.fromJson(item))
          .toList(),
      variantDetails: (json['variant_details'] as List)
          .map((item) => VariantDetail.fromJson(item))
          .toList(),
      image:
          (json['image'] as List).map((item) => Image.fromJson(item)).toList(),
      vendorDetail: VendorDetail.fromJson(json['vendor_detail']),
      viewCount: json['view_count'],
      isFavourite: json['is_favourite'],
      commissionStatus: json['commission_status'],
      commissionType: json['commission_type'],
      commissionAmount: json['commission_amount'],
      averageRating: json['average_rating'].toDouble(),
      isApproved: json['is_approved'],
      isFeatured: json['is_featured'],
      isPublished: json['is_published'],
    );
  }
}

// Model for the Specification
class Specification {
  final String type;
  final String value;

  Specification({
    required this.type,
    required this.value,
  });

  factory Specification.fromJson(Map<String, dynamic> json) {
    return Specification(
      type: json['type'],
      value: json['value'],
    );
  }
}

// Model for the Type
class Type {
  final String id;
  final String name;

  Type({
    required this.id,
    required this.name,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: json['id'],
      name: json['name'],
    );
  }
}

// Model for the TypeData
class TypeData {
  final String name;

  TypeData({
    required this.name,
  });

  factory TypeData.fromJson(Map<String, dynamic> json) {
    return TypeData(
      name: json['name'],
    );
  }
}

// Model for the Value
class Value {
  final String id;
  final String value;

  Value({
    required this.id,
    required this.value,
  });

  factory Value.fromJson(Map<String, dynamic> json) {
    return Value(
      id: json['id'],
      value: json['value'],
    );
  }
}

// Model for the ValueData
class ValueData {
  final String id;
  final String name;

  ValueData({
    required this.id,
    required this.name,
  });

  factory ValueData.fromJson(Map<String, dynamic> json) {
    return ValueData(
      id: json['id'],
      name: json['name'],
    );
  }
}

// Model for the Variant
class Variant {
  final Type type;
  final List<Value> values;

  Variant({
    required this.type,
    required this.values,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      type: Type.fromJson(json['type']),
      values:
          (json['values'] as List).map((item) => Value.fromJson(item)).toList(),
    );
  }
}

// Model for the VariantDetail
class VariantDetail {
  final String id;
  final int price;
  final int strikePrice;
  final int minOrder;
  final int maxOrder;
  final bool status;
  final int stock;
  final int initialStock;
  final List<VariantDetailValue> variants;
  final List<Image> image;

  VariantDetail({
    required this.id,
    required this.price,
    required this.strikePrice,
    required this.minOrder,
    required this.maxOrder,
    required this.status,
    required this.stock,
    required this.initialStock,
    required this.variants,
    required this.image,
  });

  factory VariantDetail.fromJson(Map<String, dynamic> json) {
    return VariantDetail(
      id: json['id'],
      price: json['price'],
      strikePrice: json['strike_price'],
      minOrder: json['min_order'],
      maxOrder: json['max_order'],
      status: json['status'],
      stock: json['stock'],
      initialStock: json['initial_stock'],
      variants: (json['variants'] as List)
          .map((item) => VariantDetailValue.fromJson(item))
          .toList(),
      image:
          (json['image'] as List).map((item) => Image.fromJson(item)).toList(),
    );
  }
}

// Model for the VariantDetailValue
class VariantDetailValue {
  final String id;
  final String type;
  final String value;
  final TypeData typeData;
  final ValueData valueData;

  VariantDetailValue({
    required this.id,
    required this.type,
    required this.value,
    required this.typeData,
    required this.valueData,
  });

  factory VariantDetailValue.fromJson(Map<String, dynamic> json) {
    return VariantDetailValue(
      id: json['id'],
      type: json['type'],
      value: json['value'],
      typeData: TypeData.fromJson(json['type_data']),
      valueData: ValueData.fromJson(json['value_data']),
    );
  }
}

// Model for the VendorDetail
class VendorDetail {
  final String id;
  final String user;
  final String slug;
  final bool isAdmin;
  final bool isVendor;
  final String companyName;
  final String companyAddress;
  final String companyPhone;
  final String? vatRegisterNo;
  final String businessEmail;
  final String companyRegistrationDate;
  final String category;
  final String? subCategory;
  final String description;
  final String? otherDocument;

  VendorDetail({
    required this.id,
    required this.user,
    required this.slug,
    required this.isAdmin,
    required this.isVendor,
    required this.companyName,
    required this.companyAddress,
    required this.companyPhone,
    this.vatRegisterNo,
    required this.businessEmail,
    required this.companyRegistrationDate,
    required this.category,
    this.subCategory,
    required this.description,
    this.otherDocument,
  });

  factory VendorDetail.fromJson(Map<String, dynamic> json) {
    return VendorDetail(
      id: json['id'],
      user: json['user'],
      slug: json['slug'],
      isAdmin: json['is_admin'] == 'True',
      isVendor: json['is_vendor'] == 'True',
      companyName: json['company_name'],
      companyAddress: json['company_address'],
      companyPhone: json['company_phone'],
      vatRegisterNo: json['vat_register_no'],
      businessEmail: json['business_email'],
      companyRegistrationDate: json['company_registration_date'],
      category: json['category'],
      subCategory: json['sub_category'],
      description: json['description'],
      otherDocument: json['other_document'],
    );
  }
}
