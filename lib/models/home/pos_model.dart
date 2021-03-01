// To parse this JSON data, do
//
//     final posModel = posModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<PosModel> posModelFromMap(String str) => List<PosModel>.from(json.decode(str).map((x) => PosModel.fromMap(x)));

String posModelToMap(List<PosModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class PosModel {
    PosModel({
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

    factory PosModel.fromMap(Map<String, dynamic> json) => PosModel(
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







