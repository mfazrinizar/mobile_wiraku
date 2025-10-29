import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:icons_plus/icons_plus.dart';
import 'header.dart';
import 'rating.dart';
import 'komentar_modal.dart';

class InfoWisata extends StatefulWidget {
  final Map<String, dynamic> data;
  final List<Map<String, String>> comments;
  final ValueChanged<List<Map<String, String>>> onSaveComments;

  const InfoWisata({
    super.key,
    required this.data,
    required this.comments,
    required this.onSaveComments,
  });

  @override
  State<InfoWisata> createState() => _InfoWisataState();
}

class _InfoWisataState extends State<InfoWisata> {
  bool _detil = false;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  void _handlePressInfo() {
    setState(() {
      _detil = !_detil;
    });
  }

  void _handlePressKomen() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return KomentarModal(
          heroName: widget.data['name'],
          initialComments: widget.comments,
          onSave: (updated) {
            widget.onSaveComments(updated);
          },
          onClose: () => Navigator.of(ctx).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    widget.data['imagePath'],
                    height: screenHeight * 0.65,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: screenHeight * 0.65,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.9 * 255),
                          Colors.black.withValues(alpha: 0 * 255),
                          Colors.black.withValues(alpha: 0.915 * 255),
                          Colors.black.withValues(alpha: 0.9 * 255),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.33, 0.66, 1.0],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                      child: Column(
                        children: [
                          Header(teks: widget.data['judul']),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5 * 255),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                _buildHeroAndRatingRow(),
                                const SizedBox(height: 2),
                                const Divider(
                                    color: Colors.white, thickness: 2.5),
                                if (_detil) ...[
                                  const SizedBox(height: 2),
                                  _buildDescriptionSection(),
                                ],
                                const SizedBox(height: 16),
                                _buildActionButtons(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeroAndRatingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            widget.data['name'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Rating(hati: widget.data['rating']),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data['description1'],
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          Text(
            widget.data['description2'],
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: _handlePressKomen,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                AntDesign.message_outline,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: _handlePressInfo,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                _detil ? Icons.info : Icons.info_outline,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Material(
          color: widget.data['themeColor'].withValues(alpha: 0.3 * 255),
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => _launchURL(widget.data['wikiUrl']),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'LEBIH BANYAK >',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
