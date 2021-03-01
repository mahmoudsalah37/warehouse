import 'package:warehouse/controllers/default/default_controller.dart';
import 'package:warehouse/models/order_items/order_items_model.dart';

class OrderItemsController extends DefaultController {
  OrderItemsController({path}) : super(path);
  final path = 'orders';
  Future<List<OrderItemsModel>> getallOrders() async {
    final response = await getData();
    final data =
        (response.data as List).map((e) => OrderItemsModel.fromMap(e)).toList();
    return data;
  }
}
