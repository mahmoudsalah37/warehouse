import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:warehouse/controllers/default/default_controller.dart';
import 'package:warehouse/models/home/item_model.dart' show ItemModel;
import 'package:warehouse/models/home/order_model.dart';

class OrderController extends DefaultController with ChangeNotifier {
  OrderController({path}) : super(path);
  final path = 'orders';
  OrderModel _orderModel =
      OrderModel(pointId: 0, branchId: 0, total: 0.0, items: <ItemModel>[]);
  Future<Response> postOrder(OrderModel orderModel) async {
    final map = orderModel.toMap();
    return postData(map);
  }

  set setOrderModel(OrderModel orderrModel) {
    this._orderModel = orderrModel;
    notifyListeners();
  }

  set setItem(ItemModel item) {
    this._orderModel.total += item.price;

    this._orderModel.items.add(item);
    notifyListeners();
  }

  void reset() {
    this._orderModel =
        OrderModel(pointId: 0, branchId: 0, total: 0.0, items: <ItemModel>[]);
    notifyListeners();
  }

  OrderModel get getOrder => this._orderModel;
}
