import 'package:bookangy/Pages/About_Screens/About.dart';
import 'package:bookangy/Pages/Login_Page.dart';
import 'package:bookangy/Pages/admin/addProduct.dart';
import 'package:bookangy/Pages/books_list.dart';

import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Main Menu'),
              elevation:
                  Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'Home Page',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                Navigator.pushNamed(context, BooksList.id);

              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info, color: Theme.of(context).primaryColor),
              title: Text('Add Book',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onTap: () {
                Navigator.pushNamed(context, AddProduct.id);
              },
            ),

            Divider(),
            ListTile(
              leading: Icon(Icons.info, color: Theme.of(context).primaryColor),
              title: Text('About',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onTap: () {
                Navigator.pushNamed(context, About.id);
              },
            ),
            Divider(),
            ListTile(
              leading:
                  Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
              title: Text('Logout',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onTap: () {
                Navigator.pushNamed(context, LoginPage.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
