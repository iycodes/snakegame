import 'package:flutter/material.dart';

class SnakePixel extends StatelessWidget {
  const SnakePixel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: DecoratedBox(
        decoration: BoxDecoration(
            // gradient: const LinearGradient(
            //     colors: [Colors.white, Colors.grey, Colors.white]),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class SnakePixel2 extends StatelessWidget {
  const SnakePixel2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: DecoratedBox(
        decoration: BoxDecoration(
            // gradient: const LinearGradient(
            //     tileMode: TileMode.mirror,
            //     colors: [Colors.grey, Colors.white, Colors.grey]),
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
