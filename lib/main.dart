import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/homePage.dart';
import 'theme/appTheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: HomePage(),
    );
  }
}
