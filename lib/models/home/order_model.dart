// To parse this JSON data, do
//
//     final orderModel = orderModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:warehouse/models/home/item_model.dart' show ItemModel;

List<OrderModel> orderModelFromMap(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromMap(x)));

String orderModelToMap(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class OrderModel {
  OrderModel({
    @required this.branchId,
    @required this.pointId,
    @required this.total,
    @required this.items,
  });

  int branchId;
  int pointId;
  double total;
  final List<ItemModel> items;

  factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
        branchId: json["branch_id"],
        pointId: json["point_id"],
        total: json["total"],
        items: List<ItemModel>.from(json["items"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "branch_id": branchId,
        "point_id": pointId,
        "total": total,
        "items": List<int>.from(items.map((x) => x.id)),
      };
}
