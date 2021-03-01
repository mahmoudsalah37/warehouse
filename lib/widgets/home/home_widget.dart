import 'dart:async';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:f_logs/model/datalog/data_log_type.dart';
import 'package:f_logs/model/flog/flog.dart';
import 'package:f_logs/model/flog/log_level.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:warehouse/controllers/home/branch/branch_controller.dart';
import 'package:warehouse/controllers/home/home_controller.dart';
import 'package:warehouse/controllers/home/item/item_controller.dart';
import 'package:warehouse/controllers/home/order/order_controller.dart';
import 'package:warehouse/models/branch/branch_model.dart';
import 'package:warehouse/models/home/item_model.dart';
import 'package:warehouse/models/home/pos_model.dart';

class BodyPageWidget extends StatefulWidget {
  BodyPageWidget({
    Key key,
    @required this.itemController,
    @required this.formKey,
    @required this.branches,
    @required this.branchTextEditingController,
    @required this.posTextEditingController,
    @required this.orderController,
  }) : super(key: key);

  final ItemController itemController;
  final GlobalKey<FormState> formKey;
  final Future<List<BranchModel>> branches;
  final TextEditingController branchTextEditingController;
  final TextEditingController posTextEditingController;
  final OrderController orderController;

  @override
  _BodyPageWidgetState createState() => _BodyPageWidgetState();
}

class _BodyPageWidgetState extends State<BodyPageWidget> {
  final _saveBtnController = RoundedLoadingButtonController();

  final _resetBtnController = RoundedLoadingButtonController();
  Timer timer;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Container(
                color: Colors.grey,
                child: FutureBuilder<List<ItemModel>>(
                    future: widget.itemController.getallItems(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data;
                        return GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6),
                          itemBuilder: (BuildContext context, int index) {
                            final itemModel = data.elementAt(index);
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return InkWell(
                                onTap: () {
                                  print(itemModel.name);
                                  Provider.of<OrderController>(context,
                                          listen: false)
                                      .setItem = itemModel;
                                },
                                splashColor: Colors.grey,
                                hoverColor: Colors.green,
                                child: Card(
                                  margin: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.food_bank_rounded,
                                        color: Colors.green,
                                        size: 40,
                                      ),
                                      Text(
                                        '${itemModel.name}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            .copyWith(color: Colors.black),
                                      ),
                                      Text(
                                        '${itemModel.price}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error);
                      } else
                        return Center(
                          child: RefreshProgressIndicator(),
                        );
                    })),
          ),
          Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Center(
                            child: Text(
                              'Bill Details',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(
                                      color: Colors.black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                    Divider(color: Colors.black),
                    Expanded(
                      flex: 8,
                      child: Container(
                        child: Consumer<OrderController>(
                            builder: (context, orderModel, w) {
                          return ListView.builder(
                            itemCount: orderModel.getOrder.items.length,
                            itemBuilder: (context, index) {
                              final itemModel =
                                  orderModel.getOrder.items.elementAt(index);

                              return Container(
                                margin: const EdgeInsets.all(4.0),
                                padding: const EdgeInsets.all(4.0),
                                color: Colors.grey,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${itemModel.name}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${itemModel.price}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2,
                                          ),
                                          Text('  SAR')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ),
                    Divider(color: Colors.black),
                    Expanded(
                        flex: 4,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Vat : 0.0',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        .copyWith(color: Colors.black),
                                  ),
                                  Text(' SAR'),
                                ],
                              ),
                              Consumer<OrderController>(
                                builder: (_, orderModel, w) {
                                  return Row(
                                    children: [
                                      Text(
                                          'Total : ${orderModel.getOrder.total}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              .copyWith(color: Colors.black)),
                                      Text(' SAR'),
                                    ],
                                  );
                                },
                              ),
                              RoundedLoadingButton(
                                  color: Colors.green,
                                  controller: _saveBtnController,
                                  onPressed: () async {
                                    final orderModel =
                                        Provider.of<OrderController>(context,
                                                listen: false)
                                            .getOrder;
                                    if (widget.formKey.currentState.validate() &
                                        orderModel.items.isNotEmpty) {
                                      final branchesData =
                                          await widget.branches;

                                      final selectedBranch =
                                          branchesData.firstWhere((element) =>
                                              element.name ==
                                              widget.branchTextEditingController
                                                  .text);

                                      orderModel.branchId = selectedBranch.id;
                                      orderModel.pointId = selectedBranch.points
                                          .firstWhere((element) =>
                                              element.name ==
                                              widget.posTextEditingController
                                                  .text)
                                          .id;
                                      int time = 1;
                                      timer =
                                          Timer(Duration(milliseconds: 1), () {
                                        time = time + 1;
                                      });

                                      final response = await widget
                                          .orderController
                                          .postOrder(orderModel);
                                      print(time.toString() +
                                          timer.isActive.toString());
                                      timer.cancel();

                                      FLog.logThis(
                                        text: response.data['data'].toString(),
                                        className:
                                            '${time.toString()} milliseconds',
                                        type: response.statusCode == 200
                                            ? LogLevel.INFO
                                            : LogLevel.ERROR,
                                        dataLogType:
                                            DataLogType.DEVICE.toString(),
                                      );
                                      if (response.statusCode == 200) {
                                        Provider.of<OrderController>(context,
                                                listen: false)
                                            .reset();
                                        _saveBtnController.success();
                                      } else {
                                        _saveBtnController.error();
                                      }
                                      final x = await FLog.getAllLogs();
                                      File file =
                                          new File("C:\\logs\\Logs.txt");
                                      file = await file.create(recursive: true);
                                      file.open();
                                      String logs = '';
                                      for (final v in x) {
                                        logs +=
                                            '  Time: ${v.timestamp}\n  Duration: ${v.className}\n  Data: ${v.text}\n  Size data: ${getStringSizeLengthFile(v.text.length)}\n  ${v.logLevel.toString()}\n-----------------------------------------------------------';
                                      }
                                      file.writeAsString(logs,
                                          mode: FileMode.append);
                                      await file.exists();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Choice items or check fields')));
                                      _saveBtnController.error();
                                    }
                                    await Future.delayed(Duration(seconds: 1));
                                    _saveBtnController.reset();
                                  },
                                  child: Text('Check out')),
                              RoundedLoadingButton(
                                  controller: _resetBtnController,
                                  color: Colors.green,
                                  onPressed: () async {
                                    Provider.of<OrderController>(context,
                                            listen: false)
                                        .reset();
                                    _resetBtnController.success();
                                    await Future.delayed(Duration(seconds: 1));
                                    _resetBtnController.reset();
                                  },
                                  child: Text('Cancel')),
                            ],
                          ),
                        )),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.branchTextEditingController.dispose();
    widget.posTextEditingController.dispose();
    if (timer != null) timer.cancel();
    super.dispose();
  }
}

class HeadPageWidget extends StatelessWidget {
  const HeadPageWidget({
    Key key,
    @required this.branches,
    @required this.branchTextEditingController,
    @required this.pos,
    @required this.posTextEditingController,
  }) : super(key: key);

  final Future<List<BranchModel>> branches;
  final TextEditingController branchTextEditingController;
  final Future<List<PosModel>> pos;
  final TextEditingController posTextEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<List<BranchModel>>(
              future: branches,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropDownSearchWidget(
                      label: 'Branch',
                      items: snapshot.data.map((e) => e.name).toList(),
                      textEditingController: branchTextEditingController
                        ..text = snapshot.data.first.name,
                      onChanged: (String v) {
                        branchTextEditingController.text = v;
                        final branchModel = snapshot.data.firstWhere(
                            (element) =>
                                element.name ==
                                branchTextEditingController.text);
                        Provider.of<BranchController>(context, listen: false)
                            .setBranch = branchModel;
                      });
                } else if (snapshot.hasError)
                  return Text('${snapshot.error}');
                else
                  return Center(child: RefreshProgressIndicator());
              }),
          FutureBuilder(
              future: Future.wait([branches, pos]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  return Consumer<BranchController>(
                      builder: (context, branchModel, w) {
                    int id = branchModel.getBranch.id;
                    if (id == null) {
                      id = snapshot.data[1].first.branchId;
                    }
                    posTextEditingController.text = (snapshot.data[1] as List)
                        .cast<PosModel>()
                        .firstWhere((element) => element.branchId == id)
                        .name;
                    Iterable<PosModel> where = snapshot.data[1]
                        .where((element) => id == element.branchId);
                    final data = where;
                    List<String> stringData =
                        data.map((e) => e.name.toString()).toList();
                    return DropDownSearchWidget(
                      label: 'POS',
                      items: stringData,
                      textEditingController: posTextEditingController,
                      onChanged: (v) {
                        posTextEditingController.text = v;
                      },
                    );
                  });
                } else if (snapshot.hasError)
                  return Text('${snapshot.error}');
                else
                  return Center(child: RefreshProgressIndicator());
              }),
        ],
      ),
    );
  }
}

class DropDownSearchWidget extends StatelessWidget {
  DropDownSearchWidget(
      {this.label = '',
      @required this.items,
      this.textEditingController,
      this.onChanged})
      : assert(items != null);
  final String label;
  final List<String> items;
  final TextEditingController textEditingController;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: UniqueKey(),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$label:',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          height: 60.0,
          constraints: BoxConstraints(maxWidth: 300, minWidth: 150),
          child: DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItem: true,
              items: items,
              onChanged: onChanged,
              autoValidateMode: AutovalidateMode.always,
              validator: (v) {
                if (v.isEmpty) {
                  return 'Choice Data';
                }
                return null;
              },
              selectedItem: textEditingController.text),
        ),
      ],
    );
  }
}
