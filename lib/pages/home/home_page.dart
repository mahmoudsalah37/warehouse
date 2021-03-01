import 'package:flutter/material.dart';
import 'package:warehouse/controllers/home/branch/branch_controller.dart';
import 'package:warehouse/controllers/home/item/item_controller.dart';
import 'package:warehouse/controllers/home/order/order_controller.dart';
import 'package:warehouse/controllers/home/pos/pos_controller.dart';
import 'package:warehouse/models/branch/branch_model.dart';
import 'package:warehouse/models/home/pos_model.dart';
import 'package:warehouse/widgets/all/all_widget.dart' show buildAppBar;
import 'package:warehouse/widgets/all/menu_drawer_widget.dart'
    show MenuDrawerWidget;
import 'package:warehouse/widgets/home/home_widget.dart'
    show BodyPageWidget, HeadPageWidget;

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState() {
    getData();
  }
  final branchController = BranchController();

  final posController = PosController();

  final itemController = ItemController();

  final branchTextEditingController = TextEditingController(text: ''),
      posTextEditingController = TextEditingController(text: '');

  final orderController = OrderController();

  final formKey = GlobalKey<FormState>();

  Future<List<BranchModel>> branches;

  Future<List<PosModel>> pos;

  getData() async {
    branches = branchController.getBranches();
    pos = posController.getallPos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MenuDrawerWidget(),
      appBar: buildAppBar(context),
      body: Form(
        key: formKey,
        child: Container(
          child: Column(
            children: [
              //Head
              HeadPageWidget(
                  branches: branches,
                  branchTextEditingController: branchTextEditingController,
                  pos: pos,
                  posTextEditingController: posTextEditingController),
              //Body
              BodyPageWidget(
                  itemController: itemController,
                  formKey: formKey,
                  branches: branches,
                  branchTextEditingController: branchTextEditingController,
                  posTextEditingController: posTextEditingController,
                  orderController: orderController),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    branchTextEditingController.dispose();
    posTextEditingController.dispose();
    super.dispose();
  }
}
