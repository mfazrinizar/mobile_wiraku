import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class KomentarModal extends StatefulWidget {
  final String heroName;
  final List<Map<String, String>> initialComments;
  final ValueChanged<List<Map<String, String>>> onSave;
  final VoidCallback onClose;

  const KomentarModal({
    super.key,
    required this.heroName,
    required this.initialComments,
    required this.onSave,
    required this.onClose,
  });

  @override
  State<KomentarModal> createState() => _KomentarModalState();
}

class _KomentarModalState extends State<KomentarModal> {
  final TextEditingController _teksInputController = TextEditingController();
  late List<Map<String, String>> _dataKomentar;

  @override
  void initState() {
    super.initState();
    _dataKomentar =
        widget.initialComments.map((e) => Map<String, String>.from(e)).toList();
  }

  void _addKomentar() {
    final text = _teksInputController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _dataKomentar.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'from': 'Atmin',
        'teks': text,
      });
      _teksInputController.clear();
    });

    widget.onSave(_dataKomentar);
  }

  @override
  void dispose() {
    _teksInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Icon(
                  AntDesign.message_fill,
                  color: Colors.deepOrangeAccent,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'KOMENTAR',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tentang ${widget.heroName}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: widget.onClose,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _dataKomentar.length,
              itemBuilder: (context, index) {
                final kom = _dataKomentar[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.deepOrangeAccent,
                            child: Text(
                              (kom['from'] ?? 'U')[0].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            kom['from'] ?? 'user',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        kom['teks'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _teksInputController,
                      decoration: InputDecoration(
                        hintText: 'Tambah komentar...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      maxLines: null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    onPressed: _addKomentar,
                    backgroundColor: Colors.deepOrangeAccent,
                    elevation: 0,
                    mini: true,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
