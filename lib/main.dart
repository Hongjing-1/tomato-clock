import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Apppagecontroller.dart';
import 'home.dart';
import 'log in.dart';
import 'Setting page.dart';
import 'Register.dart';
import 'Splash page.dart';
import 'Taskpage.dart';
import 'app_state.dart'; // App 狀態管理
import 'task_provider.dart'; // 任務狀態管理 (你需確認 TaskProvider 這個檔案名稱)

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()), // 任務狀態管理
        ChangeNotifierProvider(create: (_) => AppState()), // App 狀態管理
      ],
      child: const MyApp(),
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
        '/task': (context) => Taskpage(), // 讓 Taskpage 也能透過命名路由進入
      },
    );
  }
}
