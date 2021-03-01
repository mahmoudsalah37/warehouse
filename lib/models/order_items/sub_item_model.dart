import 'dart:convert';

class SubItemModel {
  final int id;
  final String name;
  final double price;
  final String createdAt;
  final String updatedAt;
  SubItemModel({
    this.id,
    this.name,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  SubItemModel copyWith({
    int id,
    String name,
    int price,
    String createdAt,
    String updatedAt,
  }) {
    return SubItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory SubItemModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SubItemModel(
      id: map['id']?.toInt(),
      name: map['name'],
      price: map['price']?.toDouble(),
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubItemModel.fromJson(String source) =>
      SubItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Item(id: $id, name: $name, price: $price, created_at: $createdAt, updated_at: $updatedAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SubItemModel &&
        o.id == id &&
        o.name == name &&
        o.price == price &&
        o.createdAt == createdAt &&
        o.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
