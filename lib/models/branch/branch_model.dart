// To parse this JSON data, do
//
//     final branchModel = branchModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<BranchModel> branchModelFromMap(String str) =>
    List<BranchModel>.from(json.decode(str).map((x) => BranchModel.fromMap(x)));

String branchModelToMap(List<BranchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class BranchModel {
  BranchModel({
    @required this.id,
    @required this.name,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.orders,
    @required this.points,
  });

  final int id;
  final String name;
  final dynamic createdAt;
  final dynamic updatedAt;
  final List<Order> orders;
  final List<Point> points;

  factory BranchModel.fromMap(Map<String, dynamic> json) => BranchModel(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromMap(x))),
        points: List<Point>.from(json["points"].map((x) => Point.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "orders": List<dynamic>.from(orders.map((x) => x.toMap())),
        "points": List<dynamic>.from(points.map((x) => x.toMap())),
      };
}

class Order {
  Order({
    @required this.id,
    @required this.branchId,
    @required this.pointId,
    @required this.status,
    @required this.total,
    @required this.createdAt,
    @required this.updatedAt,
  });

  final int id;
  final int branchId;
  final int pointId;
  final String status;
  final double total;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"],
        branchId: json["branch_id"],
        pointId: json["point_id"],
        status: json["status"],
        total: json["total"]?.toDouble() ?? 0.0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "branch_id": branchId,
        "point_id": pointId,
        "status": status,
        "total": total,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Point {
  Point({
    @required this.id,
    @required this.branchId,
    @required this.name,
    @required this.createdAt,
    @required this.updatedAt,
  });

  final int id;
  final int branchId;
  final String name;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory Point.fromMap(Map<String, dynamic> json) => Point(
        id: json["id"],
        branchId: json["branch_id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "branch_id": branchId,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
