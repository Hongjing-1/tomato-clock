import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled4/Apppagecontroller.dart';
import 'package:untitled4/home.dart';
import 'package:untitled4/log in.dart';
import 'Setting page.dart';
import 'Register.dart';
import 'package:untitled4/Splash page.dart';
import 'Taskpage.dart';
import 'package:provider/provider.dart';
import 'app_state.dart'; // 狀態管理檔案

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Apppagecontroller(), // 入口頁面
        '/login': (context) => login(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => Homepage(),
        '/Setting': (context) => Settingpage(),
      },
    );
  }
}









