import 'package:bookangy/Widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../store.dart';
import '../book_model.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  String _name, _price, _description, _AuthorName, _imageLocation,_stars,_numPages;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              hint: 'Product Name',
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _price = value;
              },
              hint: 'Product Price',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _numPages = value;
              },
              hint: 'Num of pages',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _description = value;
              },
              hint: 'Product Description',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _AuthorName = value;
              },
              hint: 'Product Category',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _imageLocation = value;
              },
              hint: 'Product Location',
            ),CustomTextField(
              onClick: (value) {
                _stars = value;
              },
              hint: 'stars',
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();


                  _store.addProduct(Book(
                      bookTitle:  _name,
                      numPages:  _numPages,
                      stars:_stars ,
                      description:  _description,
                      imageUrl: _imageLocation,
                      authorName:  _AuthorName,
                      price:  _price,
                    AddedBy: "Abdelrahman Ragab",



                ));
                }
              },
              child: Text('Add Product'),
            )
          ],
        ),
      ),
    );
  }
}
