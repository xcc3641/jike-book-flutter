import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class BookAppBar extends StatelessWidget {
  bool? forceElevated;
  BookAppBar({this.forceElevated, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [
              HexColor('#2D963D'),
              HexColor('#FFE40F'),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Offset.zero & bounds.size);
        },
        child: const Text(
          "Jike Book During 2021",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      centerTitle: false,
      forceElevated: forceElevated ?? false,
      backgroundColor: Colors.white,
      elevation: 8,
      pinned: true,
      automaticallyImplyLeading: false,
    );
  }
}
