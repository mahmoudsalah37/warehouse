import 'dart:io';

import 'package:f_logs/f_logs.dart';
import 'package:f_logs/utils/formatter/field_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/home/branch/branch_controller.dart';
import 'controllers/home/order/order_controller.dart';
import 'pages/order_items/order_items_page.dart';
import 'src/theme.dart' show themeData;
import 'src/strings.dart' show nameApp;
import 'pages/home/home_page.dart' show HomePage;

//Root app
void main() async {
  init();
  
  
  runApp(MyApp());
}



init() {
  /// Configuration example 1
//  LogsConfig config = LogsConfig()
//    ..isDebuggable = true
//    ..isDevelopmentDebuggingEnabled = true
//    ..customClosingDivider = "|"
//    ..customOpeningDivider = "|"
//    ..csvDelimiter = ", "
//    ..isLogsEnabled = true
//    ..encryptionEnabled = false
//    ..encryptionKey = "123"
//    ..formatType = FormatType.FORMAT_CURLY
//    ..logLevelsEnabled = [LogLevel.INFO, LogLevel.ERROR]
//    ..dataLogTypes = [
//      DataLogType.DEVICE.toString(),
//      DataLogType.NETWORK.toString(),
//      "Zubair"
//    ]
//    ..timestampFormat = TimestampFormat.TIME_FORMAT_FULL_1;

  /// Configuration example 2
//  LogsConfig config = FLog.getDefaultConfigurations()
//    ..isDevelopmentDebuggingEnabled = true
//    ..timestampFormat = TimestampFormat.TIME_FORMAT_FULL_2;

  /// Configuration example 3 Format Custom
  LogsConfig config = FLog.getDefaultConfigurations()
    ..isDevelopmentDebuggingEnabled = true
    ..timestampFormat = TimestampFormat.TIME_FORMAT_FULL_3
    ..formatType = FormatType.FORMAT_CUSTOM
    ..fieldOrderFormatCustom = [
      FieldName.TIMESTAMP,
      FieldName.LOG_LEVEL,
      FieldName.CLASSNAME,
      FieldName.METHOD_NAME,
      FieldName.TEXT,
      FieldName.EXCEPTION,
      FieldName.STACKTRACE
    ]
    ..customOpeningDivider = "|"
    ..customClosingDivider = "|";

  FLog.applyConfigurations(config);
}

//Material app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BranchController()),
        ChangeNotifierProvider(create: (_) => OrderController()),
      ],
      child: MaterialApp(
        title: nameApp,
        debugShowCheckedModeBanner: false,
        theme: themeData,
        initialRoute: '/',
        routes: {
          '/': (_) => HomePage(),
          '/history': (_) => OrderItemsPage(),
        },
      ),
    );
  }
}
