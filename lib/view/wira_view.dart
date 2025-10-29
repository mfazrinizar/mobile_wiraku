import 'package:flutter/material.dart';
import 'package:wiraku/const/wira_data.dart';

import '../components/info_wira.dart';
import '../components/item_wira.dart';
// import '../wisataku.dart';

class WiraView extends StatefulWidget {
  const WiraView({super.key});

  @override
  State<WiraView> createState() => _WiraViewState();
}

class _WiraViewState extends State<WiraView> {
  int _terpilih = 0;
  int _sebelumnya = 0;

  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  final Map<int, List<Map<String, String>>> commentsByHero = {};

  void _ubahWira(int id) {
    setState(() {
      _sebelumnya = _terpilih;
      _terpilih = id;
    });
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final daftarLain = wiraData.where((wis) => wis['id'] != _terpilih).toList();

    const double imageFraction = 0.65;
    final double minChildSize = 1.0 - imageFraction * 0.95;
    const double maxChildSize = 0.75;

    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const WisataScreen(),
      //     ),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   foregroundColor: Colors.transparent,
      // ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: InfoWira(
              data: wiraData[_terpilih],
              previousIndex: _sebelumnya,
              comments: commentsByHero[_terpilih] ?? [],
              onSaveComments: (updated) {
                setState(() {
                  commentsByHero[_terpilih] =
                      updated.map((e) => Map<String, String>.from(e)).toList();
                });
              },
            ),
          ),
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: minChildSize,
            minChildSize: minChildSize,
            maxChildSize: maxChildSize,
            builder: (BuildContext context, ScrollController scrollController) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 8,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: IntrinsicWidth(
                            child: Column(
                              children: [
                                const Text(
                                  'WIRA LAINNYA',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Divider(
                                  color: Colors.deepOrangeAccent,
                                  thickness: 2.5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: daftarLain.length,
                            itemBuilder: (context, index) {
                              final wis = daftarLain[index];
                              return ItemWira(
                                teks: wis['name'],
                                gambar: wis['imagePath'],
                                rating: wis['rating'],
                                onTap: () async {
                                  await _sheetController.animateTo(
                                    minChildSize,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                  _ubahWira(wis['id']);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 48,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onVerticalDragUpdate: (details) {
                        final screenH = MediaQuery.of(context).size.height;
                        final double delta = details.primaryDelta ?? 0;
                        final double cur = _sheetController.size;

                        final double sizeDelta = delta / screenH;

                        final double newSize =
                            (cur - sizeDelta).clamp(minChildSize, maxChildSize);
                        _sheetController.jumpTo(newSize);
                      },
                      onVerticalDragEnd: (details) {
                        final v = details.velocity.pixelsPerSecond.dy;
                        if (v < -400) {
                          _sheetController.animateTo(maxChildSize,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                        } else if (v > 400) {
                          _sheetController.animateTo(minChildSize,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                        }
                      },
                      child: SizedBox.shrink(),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
