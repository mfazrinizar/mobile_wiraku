import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String teks;

  const Header({
    super.key,
    required this.teks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        teks,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 5.0,
        ),
      ),
    );
  }
}
