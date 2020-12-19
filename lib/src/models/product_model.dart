import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.id,
    this.name = '',
    this.price = 0.0,
    this.available = true,
    this.urlImage,
  });

  String id;
  String name;
  double price;
  bool available;
  String urlImage;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    available: json["available"],
    urlImage: json["urlImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "available": available,
    "urlImage": urlImage,
  };
}
