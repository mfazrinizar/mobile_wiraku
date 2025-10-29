import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:icons_plus/icons_plus.dart';
import 'header.dart';
import 'rating.dart';
import 'komentar_modal.dart';

class InfoWira extends StatefulWidget {
  final Map<String, dynamic> data;
  final int previousIndex;
  final List<Map<String, String>> comments;
  final ValueChanged<List<Map<String, String>>> onSaveComments;

  const InfoWira({
    super.key,
    required this.data,
    required this.previousIndex,
    required this.comments,
    required this.onSaveComments,
  });

  @override
  State<InfoWira> createState() => _InfoWiraState();
}

class _InfoWiraState extends State<InfoWira> {
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
                  // BACKGROUND IMAGE WHEN THEME IS ORANGE (animated)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 0),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: animation.drive(Tween<Offset>(
                            begin: const Offset(0, 0.03),
                            end: Offset.zero,
                          ).chain(CurveTween(curve: Curves.easeOut))),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      height: screenHeight * 0.65,
                      width: double.infinity,
                      color: (widget.data['themeColor'] ?? Colors.orange)
                          .withValues(alpha: 0.25),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, animation) {
                      final int currentId = widget.data['id'] ?? 0;
                      final bool forward = currentId >= widget.previousIndex;

                      final bool isIncoming =
                          (child.key == ValueKey(currentId));

                      final Offset beginOffset = isIncoming
                          ? Offset(forward ? 1.0 : -1.0, 0)
                          : Offset(forward ? -1.0 : 1.0, 0);

                      final Tween<Offset> offsetTween =
                          Tween(begin: beginOffset, end: Offset.zero);

                      return SlideTransition(
                        position: animation.drive(
                          offsetTween.chain(CurveTween(curve: Curves.easeOut)),
                        ),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: Image.asset(
                      widget.data['imagePath'],
                      key: ValueKey(widget.data['id']),
                      height: screenHeight * 0.65,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
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
