import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Rating extends StatelessWidget {
  final int hati;

  const Rating({
    super.key,
    required this.hati,
  });

  @override
  Widget build(BuildContext context) {
    final deretHati = [1, 2, 3, 4, 5];

    return Row(
      children: deretHati.map((h) {
        return Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Icon(
            h <= hati ? AntDesign.star_fill : AntDesign.star_outline,
            color: Colors.deepOrangeAccent,
            size: 18,
          ),
        );
      }).toList(),
    );
  }
}
