import 'dart:convert';

import 'package:warehouse/models/order_items/sub_item_model.dart';

class ItemModel {
  final int id;
  final int orderId;
  final int menuItemId;
  final String createdAt;
  final String updatedAt;
  final SubItemModel item;
  ItemModel({
    this.id,
    this.orderId,
    this.menuItemId,
    this.createdAt,
    this.updatedAt,
    this.item,
  });

  ItemModel copyWith({
    int id,
    int orderId,
    int menuItemId,
    String createdAt,
    String updatedAt,
    ItemModel item,
  }) {
    return ItemModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      menuItemId: menuItemId ?? this.menuItemId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      item: item ?? this.item,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'menu_item_id': menuItemId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'item': item?.toMap(),
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ItemModel(
      id: map['id']?.toInt(),
      orderId: map['order_id']?.toInt(),
      menuItemId: map['menu_item_id']?.toInt(),
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      item: SubItemModel.fromMap(map['item']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) => ItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Item(id: $id, order_id: $orderId, menu_item_id: $menuItemId, created_at: $createdAt, updated_at: $updatedAt, item: $item)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ItemModel &&
      o.id == id &&
      o.orderId == orderId &&
      o.menuItemId == menuItemId &&
      o.createdAt == createdAt &&
      o.updatedAt == updatedAt &&
      o.item == item;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      orderId.hashCode ^
      menuItemId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      item.hashCode;
  }
}