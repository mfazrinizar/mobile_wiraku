import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ItemWisata extends StatelessWidget {
  final String teks;
  final String gambar;
  final int rating;
  final VoidCallback onTap;

  const ItemWisata({
    super.key,
    required this.teks,
    required this.gambar,
    required this.rating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: onTap,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      gambar,
                      width: 55,
                      height: 85,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          teks,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: Icon(
                              index < rating
                                  ? AntDesign.star_fill
                                  : AntDesign.star_outline,
                              color: Colors.red,
                              size: 14,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
