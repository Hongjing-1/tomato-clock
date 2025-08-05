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
import 'task_stats_page.dart'; // 新增：任務統計頁
import 'app_state.dart';
import 'task_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => AppState()),
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
        '/': (context) => Apppagecontroller(),
        '/login': (context) => login(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => Homepage(),
        '/Setting': (context) => Settingpage(),
        '/task': (context) => Taskpage(),
        '/stats': (context) => TaskStatsPage(),  // 統計頁路由
      },
    );
  }
}
