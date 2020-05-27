
import 'package:bookangy/Pages/admin/View_Users.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'addProduct.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text('Add Product'),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text('View orders'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, viewAllUsers.id);
            },
            child: Text('View  users'),
          ),
        ],
      ),
    );
  }
}
