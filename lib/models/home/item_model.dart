// To parse this JSON data, do
//
//     final itemModel = itemModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ItemModel> itemModelFromMap(String str) =>
    List<ItemModel>.from(json.decode(str).map((x) => ItemModel.fromMap(x)));

String itemModelToMap(List<ItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ItemModel {
  ItemModel({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.createdAt,
    @required this.updatedAt,
  });

  final int id;
  final String name;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory ItemModel.fromMap(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        name: json["name"],
        price: json["price"].toDouble(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
