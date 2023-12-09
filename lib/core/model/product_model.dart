class Product {
  int? id;
  int? categoryId;
  int? brandId;
  int? sellerId;
  String? name;
  double? price;
  int? stockQuantity;
  String? description;

  Product(
      {this.id,
      this.categoryId,
      this.brandId,
      this.sellerId,
      this.name,
      this.price,
      this.stockQuantity,
      this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    brandId = json['brandId'];
    sellerId = json['sellerId'];
    name = json['name'];
    price = json['price'];
    stockQuantity = json['stockQuantity'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryId'] = categoryId;
    data['brandId'] = brandId;
    data['sellerId'] = sellerId;
    data['name'] = name;
    data['price'] = price;
    data['stockQuantity'] = stockQuantity;
    data['description'] = description;
    return data;
  }
}
