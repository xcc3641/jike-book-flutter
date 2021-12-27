import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:jike_book_flutter/book.dart';

class Service {
  Future<List<Book>> fetch() async {
    final data = await rootBundle.loadString('assets/2021-books.json');
    List<dynamic> list = json.decode(data);
    List<Book> books = list.map((e) => Book.fromJson(e)).toList();
    return books;
  }
}
