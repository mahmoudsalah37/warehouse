import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'item_model.dart';

class OrderItemsModel {
  final int id;
  final int branchId;
  final int pointId;
  final String status;
  final double total;
  final String createdAt;
  final String updatedAt;
  final List<ItemModel> items;
  OrderItemsModel({
    this.id,
    this.branchId,
    this.pointId,
    this.status,
    this.total,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  OrderItemsModel copyWith({
    int id,
    int branchId,
    int pointId,
    String status,
    int total,
    String createdAt,
    String updatedAt,
    List<ItemModel> items,
  }) {
    return OrderItemsModel(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      pointId: pointId ?? this.pointId,
      status: status ?? this.status,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'branch_id': branchId,
      'point_id': pointId,
      'status': status,
      'total': total,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'items': items?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory OrderItemsModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return OrderItemsModel(
      id: map['id']?.toInt(),
      branchId: map['branch_id']?.toInt(),
      pointId: map['point_id']?.toInt(),
      status: map['status'],
      total: map['total'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      items: List<ItemModel>.from(map['items']?.map((x) => ItemModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItemsModel.fromJson(String source) => OrderItemsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Itemelement(id: $id, branch_id: $branchId, point_id: $pointId, status: $status, total: $total, created_at: $createdAt, updated_at: $updatedAt, items: $items)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is OrderItemsModel &&
      o.id == id &&
      o.branchId == branchId &&
      o.pointId == pointId &&
      o.status == status &&
      o.total == total &&
      o.createdAt == createdAt &&
      o.updatedAt == updatedAt &&
      listEquals(o.items, items);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      branchId.hashCode ^
      pointId.hashCode ^
      status.hashCode ^
      total.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      items.hashCode;
  }
}