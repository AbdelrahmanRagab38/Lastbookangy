import 'package:bookangy/Pages/book_model.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier {
  List<Book> Books = [];

  addProduct(Book product) {
    Books.add(product);
    notifyListeners();
  }


}
