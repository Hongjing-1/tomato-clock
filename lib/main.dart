import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled4/Apppagecontroller.dart';
import 'package:untitled4/home.dart';
import 'package:untitled4/log in.dart';
import 'Setting page.dart';
import 'Register.dart';
import 'package:untitled4/Splash page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Apppagecontroller(), // Splash_Screen
        '/login': (context) => login(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => Homepage(),
        '/Setting': (context) => Settingpage(),
        // 
      },
    );
  }
}







