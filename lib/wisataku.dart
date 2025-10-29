import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisataku App',
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: const WisataScreen(),
    );
  }
}

class WisataScreen extends StatelessWidget {
  const WisataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/wisata-01.jpg',
                  height: screenHeight * 0.65,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: screenHeight * 0.65,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.5 * 255),
                        Colors.transparent
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.65,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                    child: Column(
                      children: [
                        const Text(
                          'W I S A T A K U',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.0,
                          ),
                        ),
                        const Spacer(),
                        _buildLocationAndRatingRow(),
                        const SizedBox(height: 2),
                        const Divider(color: Colors.white, thickness: 2.5),
                        const SizedBox(height: 2),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lorem Ipsum, Lorem Ipsum',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Text(
                                'Lorem Ipsum, Lorem Ipsum',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildMoreInfoButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationAndRatingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Ciroyom, Bandung',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Icon(
                index < 4 ? AntDesign.heart_fill : AntDesign.heart_outline,
                color: Colors.white,
                size: 18,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildMoreInfoButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: Colors.white.withValues(alpha: 0.3 * 255),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
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
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LOKASI LAINNYA',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildLocationItem(
              imagePath: 'assets/wisata-02.jpg', title: 'Wisata B'),
          _buildLocationItem(
              imagePath: 'assets/wisata-03.jpg', title: 'Wisata C'),
          _buildLocationItem(
              imagePath: 'assets/wisata-04.jpg', title: 'Wisata D'),
        ],
      ),
    );
  }

  Widget _buildLocationItem(
      {required String imagePath, required String title}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: const Offset(0, 0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        imagePath,
                        width: 55,
                        height: 85,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
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
