import 'package:flutter/cupertino.dart';
import 'package:warehouse/controllers/default/default_controller.dart';
import 'package:warehouse/models/branch/branch_model.dart';

class BranchController extends DefaultController with ChangeNotifier {
  BranchController({path}) : super(path);
  final path = 'branches';
  BranchModel _branchModel = BranchModel();
  Future<List<BranchModel>> getBranches() async {
    final response = await getData();
    final data =
        (response.data as List).map((e) => BranchModel.fromMap(e)).toList();

    return data;
  }

  set setBranch(BranchModel branchModel) {
    _branchModel = branchModel;
    notifyListeners();
  }

  BranchModel get getBranch => this._branchModel;
}
