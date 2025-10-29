import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wiraku/view/wira_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  ));
  runApp(const WiraApp());
}

class WiraApp extends StatelessWidget {
  const WiraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wiraku App',
      theme: ThemeData(
        fontFamily: 'Poppy',
      ),
      debugShowCheckedModeBanner: false,
      home: const WiraView(),
    );
  }
}
