import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jike_book_flutter/book.dart';
import 'package:jike_book_flutter/service.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  title: Text(
                    'Jike Book During 2021',
                    style: TextStyle(color: HexColor('#FFE40F'), fontWeight: FontWeight.bold),
                  ),
                  centerTitle: false,
                  backgroundColor: Colors.white,
                  elevation: 8,
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final book = books[index];
                      return _bookCell(book);
                    },
                    childCount: books.length,
                  ),
                ),
              ],
            ),
          );
  }

  Widget _bookCell(Book book) {
    final image = 'images/${book.title}.jpg';
    var rating = '${book.rating}';
    if (rating.length == 1) {
      rating = '$rating.0';
    }
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
          leading: Image.asset(image, fit: BoxFit.cover),
          title: Text(book.title),
          subtitle: Text(book.abstract),
          trailing: TextButton(
              style: TextButton.styleFrom(primary: HexColor('#2D963D')),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('《${book.title}》在 2021 年读书会圈子中，有 ${book.count} 人在读。'),
                    action: SnackBarAction(
                      label: "查看",
                      onPressed: onPress,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_drop_up,
                    size: 24,
                  ),
                  Text(
                    count,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 12),
                ],
              )),
        ),
      ),
    );
  }
}
