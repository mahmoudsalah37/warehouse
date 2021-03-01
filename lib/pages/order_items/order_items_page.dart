import 'package:flutter/material.dart';
import 'package:warehouse/controllers/home/branch/branch_controller.dart';
import 'package:warehouse/controllers/home/order/order_controller.dart';
import 'package:warehouse/controllers/home/pos/pos_controller.dart';
import 'package:warehouse/controllers/order_items/order_items_controller.dart';
import 'package:warehouse/models/branch/branch_model.dart';
import 'package:warehouse/models/home/pos_model.dart';
import 'package:warehouse/models/order_items/order_items_model.dart';
import 'package:warehouse/widgets/all/all_widget.dart' show buildAppBar;
import 'package:warehouse/widgets/all/menu_drawer_widget.dart'
    show MenuDrawerWidget;
import 'package:warehouse/widgets/home/home_widget.dart' show HeadPageWidget;

class OrderItemsPage extends StatefulWidget {
  const OrderItemsPage();

  @override
  _OrderItemsPageState createState() => _OrderItemsPageState();
}

class _OrderItemsPageState extends State<OrderItemsPage> {
  _OrderItemsPageState() {
    getData();
  }
  final orderItemsController = OrderItemsController();
  final branchController = BranchController();

  final posController = PosController();

  final branchTextEditingController = TextEditingController(text: ''),
      posTextEditingController = TextEditingController(text: '');

  final orderController = OrderController();

  final formKey = GlobalKey<FormState>();

  Future<List<BranchModel>> branches;

  Future<List<PosModel>> pos;
  Future<List<OrderItemsModel>> orders;
  getData() async {
    branches = branchController.getBranches();
    pos = posController.getallPos();
    orders = orderItemsController.getallOrders();
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
              Expanded(
                child: BodyPageWidget(
                  future: Future.wait([orders, branches, pos]),
                  branch: branchTextEditingController,
                  posTextEditingControll: posTextEditingController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BodyPageWidget extends StatefulWidget {
  BodyPageWidget(
      {@required this.future, @required this.branch, @required this.posTextEditingControll})
      : assert(branch != null),
        assert(posTextEditingControll != null),
        assert(future != null);
  final Future future;
  final TextEditingController branch, posTextEditingControll;

  @override
  _BodyPageWidgetState createState() => _BodyPageWidgetState();
}

class _BodyPageWidgetState extends State<BodyPageWidget> {
  @override
  void initState() {
    widget.posTextEditingControll.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    });
    widget.branch.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: widget.future,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final listOfBranches =
                (snapshot.data[1] as List).cast<BranchModel>();
            final branchId = listOfBranches
                .firstWhere((element) => element.name == widget.branch.text)
                .id;
            final listOfPos = (snapshot.data[2] as List).cast<PosModel>();
            final posId = listOfPos
                .firstWhere((element) => element.name == widget.posTextEditingControll.text)
                .id;
            final listOfOrders =
                (snapshot.data[0] as List).cast<OrderItemsModel>();
            final data = listOfOrders
                .where((element) =>
                    element.branchId == branchId && element.pointId == posId)
                .toList();
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index) {
                  final orderItemModel = data.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ExpansionTile(
                      key: UniqueKey(),
                      children: orderItemModel.items
                          .map((e) => Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${e.item.name}  (${e.item.price} SAR)',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(color: Colors.black),
                                ),
                              ))
                          .toList(),
                      collapsedBackgroundColor:
                          index % 2 == 0 ? Colors.grey[300] : Colors.grey[100],
                      title: Text(
                        'total: ${orderItemModel.total}',
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: Colors.black),
                      ),
                      subtitle: Text('time: ${orderItemModel.createdAt}'),
                    ),
                  );
                });
          } else if (snapshot.hasError)
            return Text('${snapshot.error}');
          else
            return Center(
              child: RefreshProgressIndicator(),
            );
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.branch.dispose();
    widget.posTextEditingControll.dispose();
    super.dispose();
  }
}
