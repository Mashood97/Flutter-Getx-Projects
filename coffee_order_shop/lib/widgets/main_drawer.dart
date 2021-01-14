import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  var _list = [
    {
      'title': 'Home',
      'icon': Icons.home_filled,
    },
    {
      'title': 'My Orders',
      'icon': Icons.bookmark_border,
    },
    {
      'title': 'My Profile',
      'icon': Icons.person_pin,
    },
    {
      'title': 'Settings',
      'icon': Icons.settings,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Image.asset('assets/images/playstore.png'),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (ctx, index) => ListTile(
                title: Text(
                  _list[index]['title'],
                  style: Theme.of(context).textTheme.headline6,

                ),
                trailing: Icon(
                  _list[index]['icon'],
                  color: Colors.brown,
                ),
              ),
              itemCount: _list.length,
            ),
          ),
        ],
      ),
    );
  }
}
