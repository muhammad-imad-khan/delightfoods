import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int categoryId;
  final int clientId;
  final int stock;
  final bool isActive;
  final List<dynamic> categoryList;
  final List<dynamic> parentcategoryList;
  final List<dynamic> uploadedFiles;
  final List<dynamic> mediaFileList;
  final String mediaFilePath;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.clientId,
    required this.stock,
    required this.isActive,
    required this.categoryList,
    required this.parentcategoryList,
    required this.uploadedFiles,
    required this.mediaFileList,
    required this.mediaFilePath,
  });

  const Product.empty({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.price = 0,
    this.categoryId = 0,
    this.clientId = 0,
    this.stock = 0,
    this.isActive = false,
    DateTime? createdOnUTC,
    this.categoryList = const [],
    this.parentcategoryList = const [],
    this.uploadedFiles = const [],
    this.mediaFileList = const [],
    this.mediaFilePath = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['categoryId'] ?? 0,
      clientId: json['clientId'] ?? 0,
      stock: json['stock'] ?? 0,
      isActive: json['isActive'] ?? false,
      price: json['price'] ?? 0.0,
      categoryList: json['categoryList'],
      parentcategoryList: json['parentcategoryList'],
      uploadedFiles: json['uploadedFiles'],
      mediaFileList: json['mediaFileList'],
      mediaFilePath: json['mediaFilePath'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "categoryId": categoryId,
        "clientId": clientId,
        "stock": stock,
        "isActive": isActive,
        "categoryList": categoryList,
        "parentcategoryList": parentcategoryList,
        "uploadedFiles": uploadedFiles,
        "mediaFileList": mediaFileList,
        "mediaFilePath": mediaFilePath,
      };
}
