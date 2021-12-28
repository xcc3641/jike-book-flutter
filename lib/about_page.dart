import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        mini: true,
        child: const Icon(Icons.keyboard_arrow_right),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverFillViewport(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                return FutureBuilder<String>(
                  future: rootBundle.loadString('assets/about.md'),
                  builder: (ctx, shot) {
                    if (shot.hasData && shot.data != null) {
                      return Markdown(
                        selectable: true,
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                          vertical: MediaQuery.of(context).size.height * 0.2,
                        ),
                        data: shot.data!,
                        onTapLink: (_, url, ___) {
                          if (url != null) {
                            launch(url);
                          }
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
