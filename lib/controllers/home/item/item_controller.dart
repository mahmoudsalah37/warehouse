import 'package:warehouse/controllers/default/default_controller.dart';
import 'package:warehouse/models/home/item_model.dart';

class ItemController extends DefaultController {
  ItemController({path}) : super(path);
  final path = 'items';
  Future<List<ItemModel>> getallItems() async {
    final response = await getData();
    final data =
        (response.data as List).map((e) => ItemModel.fromMap(e)).toList();
    return data;
  }
}
