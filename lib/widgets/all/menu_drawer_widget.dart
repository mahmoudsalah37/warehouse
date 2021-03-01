import 'package:flutter/material.dart';

class MenuDrawerWidget extends StatelessWidget {
  const MenuDrawerWidget();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(
              'Home',
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            title: Text(
              'Orders History',
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/history');
            },
          ),
        ],
      ),
    );
  }
}
