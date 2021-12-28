import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jike_book_flutter/about_page.dart';
import 'package:jike_book_flutter/book.dart';
import 'package:jike_book_flutter/service.dart';
import 'package:jike_book_flutter/widget.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: JikeBookPage(),
    );
  }
}

class JikeBookPage extends StatefulWidget {
  const JikeBookPage({Key? key}) : super(key: key);

  @override
  State<JikeBookPage> createState() => _JikeBookPageState();
}

class _JikeBookPageState extends State<JikeBookPage> {
  final Service service = Service();
  final List<Book> books = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    books.addAll(await service.fetch());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return books.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              mini: true,
              child: const Icon(Icons.keyboard_arrow_left),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AboutPage();
                }));
              },
            ),
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                BookAppBar(),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final book = books[index];
                      return _bookCell(book);
                    },
                    childCount: books.length,
                  ),
                ),
                SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, index) {
                        return Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "- 2021 Jike Book -",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                    itemExtent: 60),
              ],
            ),
          );
  }

  Widget _bookCell(Book book) {
    var count = '${book.count}';
    if (count.length == 2) {
      count = '  $count';
    }

    final onPress = () => launch(book.doubanUrl);

    return Material(
      child: TextButton(
        style: TextButton.styleFrom(primary: HexColor(book.colors[0])),
        onPressed: onPress,
        child: ListTile(
          leading: Image.network(book.image),
          title: Text(
            book.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            book.abstract,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: TextButton(
              style: TextButton.styleFrom(primary: HexColor('#2D963D')),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('《${book.title}》在 2021 年读书会圈子中，有 ${book.count} 人在读。'),
                    action: SnackBarAction(
                      label: '查看',
                      onPressed: onPress,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_drop_up, size: 24),
                  Text(count, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 12),
                ],
              )),
        ),
      ),
    );
  }
}
