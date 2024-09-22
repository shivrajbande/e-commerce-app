import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'products_model.g.dart';

@JsonSerializable()
class Product {
  int id;
  String title;
  String description;
  String category;
  double price;
  double discountPercentage;
  List<String> images;
  String thumbnail;
  String shippingInformation;
  double rating;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.price,
      required this.discountPercentage,
      required this.images,
      required this.thumbnail,
      required this.shippingInformation,
      required this.rating,
      
      });

  // Corrected factory and toJson method names
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
