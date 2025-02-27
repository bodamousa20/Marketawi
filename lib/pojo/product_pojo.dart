class Product {
  final int id;
  final String name;
  final String brand;
  final double price;
  final int inventory;
  final String description;
  final Category category;
  final ProductImage productImage;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.inventory,
    required this.description,
    required this.category,
    required this.productImage
  });

  // Factory method to create a Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      price: (json['price'] as num).toDouble(),
      inventory: json['inventory'],
      description: json['description'],
      category: Category.fromJson(json['category']),
      productImage: ProductImage.fromJson(json['productImage']),
    );
  }
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ProductImage {
  final int id;
  final String fileName;
  final String downloadUrl;

  ProductImage({required this.id, required this.fileName, required this.downloadUrl});

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      fileName: json['fileName'],
      downloadUrl: json['downloadUrl'],
    );
  }
}


class CartResponse {
  final String message;
  final CartData data;

  CartResponse({required this.message, required this.data});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      message: json['message'],
      data: CartData.fromJson(json['data']),
    );
  }
}

class CartData {
  final int id;
  final List<CartItem> cartItemList;
  final double totalPrice;

  CartData({required this.id, required this.cartItemList, required this.totalPrice});

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json['id'],
      cartItemList: (json['cartItemList'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }
}

class CartItem {
  final int id;
  final Product product;
  final double unitPrice;
  final int quantity;

  CartItem({required this.id, required this.product, required this.unitPrice, required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      product: Product.fromJson(json['product']),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }
}

