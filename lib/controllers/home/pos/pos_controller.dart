import 'package:warehouse/controllers/default/default_controller.dart';
import 'package:warehouse/models/home/pos_model.dart';

class PosController extends DefaultController {
  PosController({path}) : super(path);
  final path = 'points';
  Future<List<PosModel>> getallPos() async {
    final response = await getData();
    final data =
        (response.data as List).map((e) => PosModel.fromMap(e)).toList();

    return data;
  }
}
