import 'package:flutter/material.dart';
import 'package:warehouse/src/strings.dart' show nameApp;

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          Icons.food_bank_outlined,
        ),
        Text(
          '$nameApp',
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    ),
  );
}